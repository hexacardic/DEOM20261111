fromRational :: Rational -> ST s (Approximation s)
fromRational r = newSTRef $ fix $ ApproxStore r r

-- Checks if an ordering relation is true for all current bounds
ordHelp :: (Rational -> Rational -> Bool) ->
	Approximation s -> Approximation s -> ST s Bool
ordHelp f x y = do
	lbx <- lowerBound x
	ubx <- upperBound x
	lby <- lowerBound y
	uby <- upperBound y
	pure $ and $ zipWith f [lbx, ubx] [lby, uby]

{-
	Check an ordering relation, making the approximations more precise until
	the result is known
-}
doOrd :: (Rational -> Rational -> Bool) ->
	Approximation s -> Approximation s -> ST s Bool
doOrd f x y = do
	isTrue <- ordHelp f x y
	isFalse <- ordHelp (\a b -> not $ f a b) x y
	if isTrue then
		pure True
	else if isFalse then
		pure False
	else
		tighten x
		tighten y
		doOrd f x y

-- Compare approximations, making them more precise until the result is known
-- Note that these may not terminate for numbers that are equal
lt, gt, le, ge :: Approximation s -> Approximation s -> ST s Bool
lt = doOrd (<)
gt = doOrd (>)
le = doOrd (<=)
ge = doOrd (>=)