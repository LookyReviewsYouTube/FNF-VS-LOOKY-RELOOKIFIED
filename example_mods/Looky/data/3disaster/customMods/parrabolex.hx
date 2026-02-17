//
function initMod(mod)
{
	mod.incomingAngleMath = function(lane, curPos, pf)
	{
		if (lane >= 0 && lane <= 3)
			return [0, mod.currentValue * -(curPos * 0.015)];
		else
			return [0, mod.currentValue * (curPos * 0.015)];
	};
}
