//
function initMod(mod)
{
    mod.subValues.set('speed', new ModifierSubValue(1.0));

	mod.strumMath = function (noteData:NotePositionData, lane:Int, pf:Int)
	{
		noteData.y += mod.currentValue * (FlxMath.fastCos((Conductor.songPosition * 0.001 * (1.2) +
			(lane % NoteMovement.keyCount) * (2.0)) * (5) * mod.subValues.get('speed')
			.value * 0.2) * Note.swagWidth * 0.4);
	}
}
