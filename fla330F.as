//BFDIA 5b
//fla330F.as
//Purpose: Contains most game code.

function resetLevel()
{
    charCount = startLocations[currentLevel].length;
    levelWidth = levels[currentLevel][0].length;
    levelHeight = levels[currentLevel].length;
    copyLevel(levels[currentLevel]);
    charDepth = levelWidth * levelHeight + charCount * 2;
    charCount2 = 0;
    HPRC1 = HPRC2 = 1000000;
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        var _loc2 = startLocations[currentLevel][_loc1][0];
        char[_loc1] = new Character(_loc2, startLocations[currentLevel][_loc1][1] * 30 + startLocations[currentLevel][_loc1][2] * 30 / 100, startLocations[currentLevel][_loc1][3] * 30 + startLocations[currentLevel][_loc1][4] * 30 / 100, 70 + _loc1 * 40, 400 - _loc1 * 30, 0, 0, false, 4, false, 0, 200, 200, 30, startLocations[currentLevel][_loc1][5], -1, new Array(0), charD[_loc2][0], charD[_loc2][1], charD[_loc2][2], charD[_loc2][2], charD[_loc2][3], false, charD[_loc2][4], 0, 2, 0, new Array(0), 0, 0, 0, 0, charD[_loc2][6]);
        if (_loc2 <= 5)
        {
            ++charCount2;
        } // end if
        if (_loc2 == 36)
        {
            HPRC1 = _loc1;
        } // end if
        if (_loc2 == 35)
        {
            HPRC2 = _loc1;
        } // end if
        if (char[_loc1].charState == 3 || char[_loc1].charState == 4)
        {
            char[_loc1].speed = startLocations[currentLevel][_loc1][6][0] * 10 + startLocations[currentLevel][_loc1][6][1];
        } // end if
    } // end of for
    drawLevel();
    drawCharacters();
    recover = false;
    cornerHangTimer = 0;
    charsAtEnd = 0;
    control = 0;
    cutScene = 0;
    white._visible = true;
    bgXScale = ((levelWidth - 32) * 10 + 960) / 9.600000;
    bgYScale = ((levelHeight - 18) * 10 + 540) / 5.400000;
    bg._xscale = Math.max(bgXScale, bgYScale);
    bg._yscale = Math.max(bgXScale, bgYScale);
    bg.gotoAndStop(bgs[currentLevel] + 1);
    levelShadow.cacheAsBitmap = true;
    levelStill.cacheAsBitmap = true;
    bg.cacheAsBitmap = true;
    cameraX = Math.min(Math.max(char[0].x - 480, 0), levelWidth * 30 - 960);
    cameraY = Math.min(Math.max(char[0].y - 270, 0), levelHeight * 30 - 540);
    levelButtons.textie.text = numberToText(currentLevel + 1, true) + ". " + levelName[currentLevel];
    gotThisCoin = false;
    levelTimer = 0;
    levelTimer2 = getTimer();
    if (char[0].charState <= 9)
    {
        changeControl();
    } // end if
} // End of the function
function copyLevel(thatLevel)
{
    thisLevel = new Array(thatLevel.length);
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        thisLevel[_loc2] = new Array(thatLevel[_loc2].length);
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            thisLevel[_loc2][_loc1] = thatLevel[_loc2][_loc1];
        } // end of for
    } // end of for
} // End of the function
function numberToText(i, hundreds)
{
    if (hundreds)
    {
        if (i < 10)
        {
            return ("00" + i);
        }
        else if (i < 100)
        {
            return ("0" + i);
        }
        else
        {
            return (i);
        } // end else if
    }
    else if (i == 0)
    {
        return ("00");
    }
    else if (i < 10)
    {
        return ("0" + i);
    }
    else
    {
        return (i);
    } // end else if
} // End of the function
function toHMS(i)
{
    var _loc5 = Math.floor(i / 3600000);
    var _loc3 = Math.floor(i / 60000) % 60;
    var _loc2 = Math.floor(i / 1000) % 60;
    var _loc4 = Math.floor(i / 100) % 10;
    return (numberToText(_loc5, false) + ":" + numberToText(_loc3, false) + ":" + numberToText(_loc2, false) + "." + _loc4);
} // End of the function
function drawLevel()
{
    if (playMode == 0 && currentLevel >= 1)
    {
        removeTileMovieClips();
        addTileMovieClips();
    } // end if
    for (var _loc3 = 0; _loc3 < 6; ++_loc3)
    {
        switchable[_loc3] = new Array(0);
    } // end of for
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            if (thisLevel[_loc2][_loc1] >= 1)
            {
                if (blockProperties[thisLevel[_loc2][_loc1]][12] >= 1)
                {
                    switchable[blockProperties[thisLevel[_loc2][_loc1]][12] - 1].push([_loc1, _loc2]);
                } // end if
                if (blockProperties[thisLevel[_loc2][_loc1]][14])
                {
                    addTileMovieClip(_loc1, _loc2, levelActive3);
                }
                else if (blockProperties[thisLevel[_loc2][_loc1]][11] >= 1)
                {
                    addTileMovieClip(_loc1, _loc2, levelActive2);
                    if (blockProperties[thisLevel[_loc2][_loc1]][11] >= 7 && blockProperties[thisLevel[_loc2][_loc1]][11] <= 12)
                    {
                        levelActive2["tileX" + _loc1 + "Y" + _loc2].lever._rotation = 60;
                    } // end if
                }
                else if (blockProperties[thisLevel[_loc2][_loc1]][8])
                {
                    addTileMovieClip(_loc1, _loc2, levelActive);
                }
                else
                {
                    addTileMovieClip(_loc1, _loc2, levelStill);
                } // end else if
                if (thisLevel[_loc2][_loc1] == 6)
                {
                    locations[0] = _loc1;
                    locations[1] = _loc2;
                    if (bgs[currentLevel] == 9 || bgs[currentLevel] == 10)
                    {
                        levelActive["tileX" + _loc1 + "Y" + _loc2].bg.gotoAndStop(2);
                    } // end if
                } // end if
                if (thisLevel[_loc2][_loc1] == 12)
                {
                    locations[2] = _loc1;
                    locations[3] = _loc2;
                    locations[4] = 1000;
                    locations[5] = 0;
                } // end if
            } // end if
        } // end of for
    } // end of for
} // End of the function
function addTileMovieClip(x, y, level)
{
    var _loc5 = thisLevel[y][x];
    level.attachMovie("tile" + Math.floor(_loc5 / 10), "tileX" + x + "Y" + y, y * levelWidth + x, {_x: x * 30, _y: y * 30});
    level["tileX" + x + "Y" + y].gotoAndStop(_loc5 % 10 + 1);
    if (_loc5 == 6)
    {
        level["tileX" + x + "Y" + y].light.gotoAndStop(charCount2);
        for (var _loc2 = 0; _loc2 < 2; ++_loc2)
        {
            for (var _loc1 = 0; _loc1 < 4; ++_loc1)
            {
                setAmbientShadow(x - _loc2, y - _loc1);
            } // end of for
        } // end of for
    }
    else if (_loc5 >= 110 && _loc5 <= 129)
    {
        for (var _loc2 = 0; _loc2 < 3; ++_loc2)
        {
            for (var _loc1 = 0; _loc1 < 2; ++_loc1)
            {
                setAmbientShadow(x - _loc2, y - _loc1);
            } // end of for
        } // end of for
    }
    else if (blockProperties[thisLevel[y][x]][10])
    {
        setAmbientShadow(x, y);
    } // end else if
    if (blockProperties[thisLevel[y][x]][13])
    {
        setBorder(x, y, levelStill["tileX" + x + "Y" + y].tileBorder, _loc5);
    } // end if
} // End of the function
function setAmbientShadow(x, y)
{
    levelShadow.attachMovie("tileShadow", "tileX" + x + "Y" + y, y * levelWidth + x, {_x: x * 30, _y: y * 30});
    var _loc5 = 0;
    for (var _loc1 = 0; _loc1 < 4; ++_loc1)
    {
        var _loc4 = blockProperties[thisLevel[y + cardinal[_loc1][1]][x + cardinal[_loc1][0]]][12];
        if (blockProperties[thisLevel[y + cardinal[_loc1][1]][x + cardinal[_loc1][0]]][_loc1] && (_loc4 == 0 || _loc4 == 6))
        {
            _loc5 = _loc5 + Math.pow(2, 3 - _loc1);
        } // end if
    } // end of for
    levelShadow["tileX" + x + "Y" + y].ambientShadow.gotoAndStop(_loc5 + 1);
    for (var _loc1 = 0; _loc1 < 4; ++_loc1)
    {
        if (!blockProperties[thisLevel[y][x + diagonal[_loc1][0]]][opposite(_loc1, 0)] && !blockProperties[thisLevel[y + diagonal[_loc1][1]][x]][opposite(_loc1, 1)] && blockProperties[thisLevel[y + diagonal[_loc1][1]][x + diagonal[_loc1][0]]][opposite(_loc1, 0)] && blockProperties[thisLevel[y + diagonal[_loc1][1]][x + diagonal[_loc1][0]]][12] == 0 && blockProperties[thisLevel[y + diagonal[_loc1][1]][x + diagonal[_loc1][0]]][opposite(_loc1, 1)] && blockProperties[thisLevel[y + diagonal[_loc1][1]][x + diagonal[_loc1][0]]][12] == 0)
        {
            levelShadow["tileX" + x + "Y" + y].ambientShadow2["a" + _loc1].gotoAndStop(2);
            continue;
        } // end if
        levelShadow["tileX" + x + "Y" + y].ambientShadow2["a" + _loc1].gotoAndStop(1);
    } // end of for
} // End of the function
function setBorder(x, y, tile, s)
{
    var _loc6 = 0;
    for (var _loc1 = 0; _loc1 < 4; ++_loc1)
    {
        if (thisLevel[y + cardinal[_loc1][1]][x + cardinal[_loc1][0]] != s && !outOfRange(x + cardinal[_loc1][0], y + cardinal[_loc1][1]))
        {
            _loc6 = _loc6 + Math.pow(2, 3 - _loc1);
        } // end if
    } // end of for
    tile.ambientShadow.gotoAndStop(_loc6 + 1);
    for (var _loc1 = 0; _loc1 < 4; ++_loc1)
    {
        if (thisLevel[y][x + diagonal[_loc1][0]] == s && thisLevel[y + diagonal[_loc1][1]][x] == s && thisLevel[y + diagonal[_loc1][1]][x + diagonal[_loc1][0]] != s)
        {
            tile.ambientShadow2["a" + _loc1].gotoAndStop(2);
            continue;
        } // end if
        tile.ambientShadow2["a" + _loc1].gotoAndStop(1);
    } // end of for
} // End of the function
function outOfRange(x, y)
{
    return (x < 0 || y < 0 || x >= levelWidth || y >= levelHeight);
} // End of the function
function opposite(i, xOrY)
{
    if (xOrY == 0)
    {
        return (3.500000 - Math.abs(i - 1.500000));
    }
    else if (xOrY == 1)
    {
        return (Math.floor(i / 2));
    } // end else if
} // End of the function
function drawCharacters()
{
    if (playMode == 0 && currentLevel >= 1)
    {
        for (var _loc1 = 0; _loc1 < startLocations[currentLevel - transitionType].length; ++_loc1)
        {
            levelChar["char" + _loc1].removeMovieClip();
        } // end of for
    }
    else
    {
        for (var _loc1 = 0; _loc1 < startLocations[currentLevel].length; ++_loc1)
        {
            levelChar["char" + _loc1].removeMovieClip();
        } // end of for
    } // end else if
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        levelChar.attachMovie("char", "char" + _loc1, charDepth - _loc1 * 2, {_x: char[_loc1].x, _y: char[_loc1].y});
        levelChar["char" + _loc1].gotoAndStop(char[_loc1].id + 1);
        levelChar["char" + _loc1].leg1.gotoAndStop(1);
        levelChar["char" + _loc1].leg2.gotoAndStop(1);
        if (char[_loc1].charState <= 1)
        {
            levelChar["char" + _loc1]._visible = false;
        } // end if
        if (charD[id][5])
        {
            levelChar["char" + _loc1].cacheAsBitmap = true;
        } // end if
        if (char[_loc1].charState == 9)
        {
            char[_loc1].dire = 2;
            levelChar["char" + _loc1].charBody.gotoAndStop(2);
            levelChar["char" + _loc1].charBody.mouth.gotoAndStop(3);
            levelChar["char" + _loc1].charBody.mouth.mouth.gotoAndStop(57);
        } // end if
        if (_loc1 == HPRC2)
        {
            HPRCBubble.attachMovie("charImage", "charImage", 0, {_x: char[_loc1].x, _y: char[_loc1].y, _xscale: 143, _yscale: 143});
        } // end if
    } // end of for
} // End of the function
function startCutScene()
{
    if (cutScene == 0)
    {
        if (toSeeCS)
        {
            cutScene = 1;
            cutSceneLine = 0;
            displayLine(currentLevel, cutSceneLine);
            char[control].dire = Math.ceil(char[control].dire / 2) * 2;
        }
        else
        {
            rescue();
            for (var _loc2 = 0; _loc2 < dialogueChar[currentLevel].length; ++_loc2)
            {
                var _loc1 = dialogueChar[currentLevel][_loc2];
                if (_loc1 >= 50 && _loc1 < 60)
                {
                    leverSwitch(_loc1 - 50);
                } // end if
            } // end of for
            cutScene = 3;
        } // end if
    } // end else if
} // End of the function
function endCutScene()
{
    toSeeCS = false;
    cutScene = 2;
    rescue();
    csBubble.gotoAndPlay(17);
} // End of the function
function rescue()
{
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        if (char[_loc1].charState == 9)
        {
            char[_loc1].charState = 10;
            levelChar["char" + _loc1].charBody.mouth.gotoAndStop(1);
        } // end if
    } // end of for
} // End of the function
function displayLine(level, line)
{
    var _loc2 = dialogueChar[level][line];
    if (_loc2 >= 50 && _loc2 < 60)
    {
        leverSwitch(_loc2 - 50);
        ++cutSceneLine;
        ++line;
        _loc2 = dialogueChar[level][line];
    } // end if
    var _loc5;
    if (_loc2 == 99)
    {
        _loc5 = 480;
    }
    else
    {
        _loc5 = Math.min(Math.max(char[_loc2].x, bubWidth / 2 + bubMargin), 960 - bubWidth / 2 - bubMargin);
        putDown(_loc2);
    } // end else if
    _root.csBubble.gotoAndPlay(2);
    _root.csBubble._x = _loc5;
    if (char[control].y - cameraY > 270)
    {
        _root.csBubble._y = bubMargin + bubHeight / 2;
    }
    else
    {
        _root.csBubble._y = 520 - bubMargin - bubHeight / 2;
    } // end else if
    if (_loc2 == 99)
    {
        _root.csBubble.csBubble2.gotoAndStop(2);
    }
    else
    {
        _root.csBubble.csBubble2.gotoAndStop(1);
        _root.csBubble.csBubble2.box.charBody.gotoAndStop(char[_loc2].id + 1);
        _root.levelChar["char" + _loc2].charBody.gotoAndStop(Math.ceil(char[_loc2].dire / 2) * 2);
        _root.levelChar["char" + _loc2].charBody.mouth.gotoAndStop(1);
        _root.levelChar["char" + _loc2].charBody.mouth.gotoAndStop(dialogueFace[level][line]);
    } // end else if
    _root.csBubble.csBubble2.textie.text = dialogueText[level][line];
} // End of the function
function leverSwitch(j)
{
    for (var _loc5 = 0; _loc5 < switchable[j].length; ++_loc5)
    {
        var _loc4 = switchable[Math.min(j, 5)][_loc5][0];
        var _loc3 = switchable[Math.min(j, 5)][_loc5][1];
        for (var _loc1 = 0; _loc1 < switches[j].length; ++_loc1)
        {
            if (thisLevel[_loc3][_loc4] == switches[j][_loc1 * 2])
            {
                thisLevel[_loc3][_loc4] = switches[j][_loc1 * 2 + 1];
                levelActive["tileX" + _loc4 + "Y" + _loc3].gotoAndStop(switches[j][_loc1 * 2 + 1] % 10 + 1);
                continue;
            } // end if
            if (thisLevel[_loc3][_loc4] == switches[j][_loc1 * 2 + 1])
            {
                thisLevel[_loc3][_loc4] = switches[j][_loc1 * 2];
                levelActive["tileX" + _loc4 + "Y" + _loc3].gotoAndStop(switches[j][_loc1 * 2] % 10 + 1);
            } // end if
        } // end of for
    } // end of for
    for (var _loc6 = 0; _loc6 < charCount; ++_loc6)
    {
        char[_loc6].justChanged = 2;
        checkDeath(_loc6);
    } // end of for
} // End of the function
function solidAt(x, y)
{
    var _loc1 = getBlockTypeAt(x, y);
    return (blockProperties[_loc1][0] && blockProperties[_loc1][1] && blockProperties[_loc1][2] && blockProperties[_loc1][3]);
} // End of the function
function solidCeiling(x, y)
{
    return (blockProperties[getBlockTypeAt(x, y)][0]);
} // End of the function
function safeToStandAt(x, y)
{
    var _loc1 = getBlockTypeAt(x, y);
    return (blockProperties[_loc1][1] && !blockProperties[_loc1][5] && _loc1 != 14 && _loc1 != 16 && _loc1 != 83 && _loc1 != 85);
} // End of the function
function getBlockTypeAt(x, y)
{
    return (thisLevel[Math.floor(y / 30)][Math.floor(x / 30)]);
} // End of the function
function verticalProp(i, sign, prop, x, y)
{
    var _loc6 = -0.500000 * sign + 0.500000;
    var _loc4 = Math.floor((y - char[i].h * _loc6) / 30);
    if (prop <= 3 && sign == -1 && _loc4 == -1)
    {
        return (true);
    } // end if
    if (prop >= 4 && prop <= 7)
    {
        for (var _loc1 = Math.floor((x - char[i].w) / 30); _loc1 <= Math.floor((x + char[i].w - 0.010000) / 30); ++_loc1)
        {
            if (blockProperties[thisLevel[_loc4][_loc1]][prop - 4] && !blockProperties[thisLevel[_loc4][_loc1]][prop])
            {
                return (false);
            } // end if
        } // end of for
    } // end if
    for (var _loc1 = Math.floor((x - char[i].w) / 30); _loc1 <= Math.floor((x + char[i].w - 0.010000) / 30); ++_loc1)
    {
        if (blockProperties[thisLevel[_loc4][_loc1]][prop])
        {
            if (prop != 1 || !ifCarried(i) || allSolid(thisLevel[_loc4][_loc1]))
            {
                return (true);
            } // end if
        } // end if
    } // end of for
    return (false);
} // End of the function
function horizontalProp(i, sign, prop, x, y)
{
    var _loc2 = Math.floor((x + char[i].w * sign) / 30);
    if (prop <= 3 && (sign == -1 && _loc2 <= -1 || sign == 1 && _loc2 >= levelWidth))
    {
        return (true);
    } // end if
    if (prop >= 4 && prop <= 7)
    {
        for (var _loc1 = Math.floor((y - char[i].h) / 30); _loc1 <= Math.floor((y - 0.010000) / 30); ++_loc1)
        {
            if (blockProperties[thisLevel[_loc1][_loc2]][prop - 4] && !blockProperties[thisLevel[_loc1][_loc2 - sign]][prop - 4] && !blockProperties[thisLevel[_loc1][_loc2]][prop])
            {
                return (false);
            } // end if
        } // end of for
    } // end if
    for (var _loc1 = Math.floor((y - char[i].h) / 30); _loc1 <= Math.floor((y - 0.010000) / 30); ++_loc1)
    {
        if (blockProperties[thisLevel[_loc1][_loc2]][prop])
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function verticalType(i, sign, prop, pist)
{
    var _loc7 = -0.500000 * sign + 0.500000;
    var _loc3 = Math.floor((char[i].y - char[i].h * _loc7) / 30);
    var _loc4 = false;
    for (var _loc1 = Math.floor((char[i].x - char[i].w) / 30); _loc1 <= Math.floor((char[i].x + char[i].w - 0.010000) / 30); ++_loc1)
    {
        if (thisLevel[_loc3][_loc1] == prop)
        {
            if (pist)
            {
                levelActive["tileX" + _loc1 + "Y" + _loc3].piston.gotoAndPlay(2);
            } // end if
            _loc4 = true;
        } // end if
    } // end of for
    return (_loc4);
} // End of the function
function horizontalType(i, sign, prop)
{
    var _loc3 = Math.floor((char[i].x + char[i].w * sign) / 30);
    for (var _loc1 = Math.floor((char[i].y - char[i].h) / 30); _loc1 <= Math.floor((char[i].y - 0.010000) / 30); ++_loc1)
    {
        if (thisLevel[_loc1][_loc3] == prop)
        {
            return (true);
        } // end if
    } // end of for
    return (false);
} // End of the function
function checkButton(i)
{
    if (char[i].onob)
    {
        var _loc4 = Math.ceil(char[i].y / 30);
        if (_loc4 >= 0 && _loc4 <= levelHeight - 1)
        {
            var _loc6;
            for (var _loc3 = Math.floor((char[i].x - char[i].w) / 30); _loc3 <= Math.floor((char[i].x + char[i].w) / 30); ++_loc3)
            {
                _loc6 = blockProperties[thisLevel[_loc4][_loc3]][11];
                if (_loc6 >= 13)
                {
                    if (levelActive2["tileX" + _loc3 + "Y" + _loc4].button._currentframe != 2)
                    {
                        leverSwitch(_loc6 - 13);
                        levelActive2["tileX" + _loc3 + "Y" + _loc4].button.gotoAndStop(2);
                    } // end if
                    var _loc5 = true;
                    for (var _loc1 = 0; _loc1 < char[i].buttonsPressed.length; ++_loc1)
                    {
                        if (char[i].buttonsPressed[_loc1][0] == _loc3 && char[i].buttonsPressed[_loc1][1] == _loc4)
                        {
                            _loc5 = false;
                        } // end if
                    } // end of for
                    if (_loc5)
                    {
                        char[i].buttonsPressed.push([_loc3, _loc4]);
                    } // end if
                    break;
                } // end if
            } // end of for
        } // end if
    } // end if
} // End of the function
function checkButton2(i, bypass)
{
    if (char[i].y < levelHeight * 30 + 30)
    {
        var _loc8 = char[i].buttonsPressed.length;
        for (var _loc5 = 0; _loc5 < _loc8; ++_loc5)
        {
            var _loc4 = char[i].buttonsPressed[_loc5][0];
            var _loc6 = char[i].buttonsPressed[_loc5][1];
            if (!char[i].onob || char[i].standingOn >= 0 || char[i].x < _loc4 * 30 - char[i].w || char[i].x >= _loc4 * 30 + 30 + char[i].w || bypass)
            {
                var _loc7 = true;
                for (var _loc3 = 0; _loc3 < charCount; ++_loc3)
                {
                    if (_loc3 != i)
                    {
                        for (var _loc2 = 0; _loc2 < char[_loc3].buttonsPressed.length; ++_loc2)
                        {
                            if (char[_loc3].buttonsPressed[_loc2][0] == _loc4 && char[_loc3].buttonsPressed[_loc2][1] == _loc6)
                            {
                                _loc7 = false;
                            } // end if
                        } // end of for
                    } // end if
                } // end of for
                if (_loc7)
                {
                    leverSwitch(blockProperties[thisLevel[_loc6][_loc4]][11] - 13);
                    levelActive2["tileX" + _loc4 + "Y" + _loc6].button.gotoAndPlay(3);
                } // end if
                for (var _loc3 = 0; _loc3 < _loc8; ++_loc3)
                {
                    if (_loc3 > _loc5)
                    {
                        char[i].buttonsPressed[_loc3][0] = char[i].buttonsPressed[_loc3 - 1][0];
                        char[i].buttonsPressed[_loc3][1] = char[i].buttonsPressed[_loc3 - 1][1];
                    } // end if
                } // end of for
                char[i].buttonsPressed.pop();
            } // end if
        } // end of for
    } // end if
} // End of the function
function checkDeath(i)
{
    for (var _loc3 = Math.floor((char[i].y - char[i].h) / 30); _loc3 <= Math.floor((char[i].y - 0.010000) / 30); ++_loc3)
    {
        for (var _loc1 = Math.floor((char[i].x - char[i].w) / 30); _loc1 <= Math.floor((char[i].x + char[i].w) / 30); ++_loc1)
        {
            if (blockProperties[thisLevel[_loc3][_loc1]][4] || blockProperties[thisLevel[_loc3][_loc1]][5] || blockProperties[thisLevel[_loc3][_loc1]][6] || blockProperties[thisLevel[_loc3][_loc1]][7])
            {
                startDeath(i);
            } // end if
        } // end of for
    } // end of for
} // End of the function
function centered(i, len)
{
    if (i % 2 == 0)
    {
        return ((len - i - 2 + len % 2) / 2);
    }
    else
    {
        return ((i + len - 1 + len % 2) / 2);
    } // end else if
} // End of the function
function onlyConveyorsUnder(i)
{
    var _loc8 = Math.floor(char[i].y / 30 + 0.500000);
    var _loc4 = Math.floor((char[i].x - char[i].w) / 30);
    var _loc6 = Math.floor((char[i].x + char[i].w - 0.010000) / 30);
    var _loc3 = 0;
    for (var _loc2 = 0; _loc2 <= _loc6 - _loc4; ++_loc2)
    {
        var _loc5 = centered(_loc2, 1 + _loc6 - _loc4) + _loc4;
        var _loc1 = thisLevel[_loc8][_loc5];
        if (blockProperties[_loc1][1])
        {
            if (_loc1 == 14 || _loc1 == 83)
            {
                if (_loc3 == 0)
                {
                    _loc3 = -2.480000;
                } // end if
                continue;
            } // end if
            if (_loc1 == 16 || _loc1 == 85)
            {
                if (_loc3 == 0)
                {
                    _loc3 = 2.480000;
                } // end if
                continue;
            } // end if
            if (_loc2 == 0 || char[i].charState == 10)
            {
                return (0);
            } // end if
        } // end if
    } // end of for
    return (_loc3);
} // End of the function
function newTileUp(i)
{
    return (Math.floor((char[i].y - char[i].h) / 30) < Math.floor((char[i].py - char[i].h) / 30));
} // End of the function
function newTileDown(i)
{
    return (Math.ceil(char[i].y / 30) > Math.ceil(char[i].py / 30));
} // End of the function
function newTileHorizontal(i, sign)
{
    return (Math.ceil(sign * (char[i].x + char[i].w * sign) / 30) > Math.ceil(sign * (char[i].px + char[i].w * sign) / 30));
} // End of the function
function exitTileHorizontal(i, sign)
{
    return (Math.ceil(sign * (char[i].x - char[i].w * sign) / 30) > Math.ceil(sign * (char[i].px - char[i].w * sign) / 30));
} // End of the function
function exitTileVertical(i, sign)
{
    var _loc1 = 0.500000 * sign + 0.500000;
    return (Math.ceil(sign * (char[i].y - char[i].h * _loc1) / 30) > Math.ceil(sign * (char[i].py - char[i].h * _loc1) / 30));
} // End of the function
function submerge(i)
{
    if (char[i].temp > 0)
    {
        char[i].temp = 0;
    } // end if
    var _loc2 = somewhereSubmerged(i);
    if (char[i].submerged <= 1 && _loc2 >= 2)
    {
        char[i].weight2 = char[i].weight2 - 0.160000;
        rippleWeight(i, 0.160000, -1);
        char[i].vx = char[i].vx * 0.100000;
        char[i].vy = char[i].vy * 0.100000;
    } // end if
    char[i].submerged = _loc2;
} // End of the function
function unsubmerge(i)
{
    if (exitTileHorizontal(i, -1) || exitTileHorizontal(i, 1) || exitTileVertical(i, 1) || exitTileVertical(i, -1))
    {
        var _loc2 = somewhereSubmerged(i);
        if (_loc2 == 0 && char[i].submerged >= 1)
        {
            if (char[i].submerged == 2 && exitTileVertical(i, -1) && char[i].weight2 < 0 && !ifCarried(i))
            {
                char[i].vy = 0;
                char[i].y = Math.ceil(char[i].y / 30) * 30;
                _loc2 = 1;
            } // end if
            char[i].weight2 = char[i].weight2 + 0.160000;
            rippleWeight(i, 0.160000, 1);
        } // end if
        char[i].submerged = _loc2;
    } // end if
} // End of the function
function heat(i)
{
    if (char[i].submerged == 0)
    {
        char[i].temp = char[i].temp + char[i].heatSpeed;
    } // end if
    char[i].justChanged = 2;
    if (char[i].temp > 50 && char[i].id != 3)
    {
        startDeath(i);
        if (char[i].id == 2)
        {
            extinguish(i);
        } // end if
    } // end if
    if (char[i].heated == 1)
    {
        unheat(i);
    } // end if
} // End of the function
function unheat(i)
{
    if (exitTileHorizontal(i, -1) || exitTileHorizontal(i, 1) || exitTileVertical(i, 1) || exitTileVertical(i, -1))
    {
        if (!somewhereHeated(i))
        {
            char[i].heated = 0;
        } // end if
    } // end if
} // End of the function
function extinguish(i)
{
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        if (char[_loc1].charState >= 5 && _loc1 != i && char[_loc1].temp > 0)
        {
            if (Math.abs(char[i].x - char[_loc1].x) < char[i].w + char[_loc1].w && char[_loc1].y > char[i].y - char[i].h && char[_loc1].y < char[i].y + char[_loc1].h)
            {
                char[_loc1].temp = 0;
            } // end if
        } // end if
    } // end of for
} // End of the function
function somewhereSubmerged(i)
{
    var _loc3 = 0;
    for (var _loc5 = Math.floor((char[i].x - char[i].w) / 30); _loc5 <= Math.floor((char[i].x + char[i].w) / 30); ++_loc5)
    {
        var _loc6 = Math.floor((char[i].y - char[i].h) / 30);
        var _loc4 = Math.floor(char[i].y / 30);
        for (var _loc1 = _loc6; _loc1 <= _loc4; ++_loc1)
        {
            if (blockProperties[thisLevel[_loc1][_loc5]][14])
            {
                if (_loc1 == _loc4)
                {
                    if (_loc3 == 0)
                    {
                        _loc3 = 2;
                    } // end if
                    continue;
                } // end if
                _loc3 = 3;
            } // end if
        } // end of for
    } // end of for
    return (_loc3);
} // End of the function
function somewhereHeated(i)
{
    for (var _loc3 = Math.floor((char[i].x - char[i].w) / 30); _loc3 <= Math.floor((char[i].x + char[i].w) / 30); ++_loc3)
    {
        for (var _loc2 = Math.floor((char[i].y - char[i].h) / 30); _loc2 <= Math.floor(char[i].y / 30); ++_loc2)
        {
            if (thisLevel[_loc2][_loc3] == 15)
            {
                return (true);
            } // end if
        } // end of for
    } // end of for
    return (false);
} // End of the function
function xOff(i)
{
    return (char[char[i].carriedBy].w * (Math.ceil(char[char[i].carriedBy].dire / 2) * 2 - 3) * 0.700000);
} // End of the function
function xOff2(i)
{
    return (char[i].w * (Math.ceil(char[i].dire / 2) * 2 - 3) * 0.700000);
} // End of the function
function yOff(i)
{
    if (char[i].charState == 6)
    {
        return (char[char[i].carriedBy].h2);
    }
    else
    {
        return (char[char[i].carriedBy].h2 - 13);
    } // end else if
} // End of the function
function stopCarrierX(i, x)
{
    if (ifCarried(i))
    {
        char[char[i].carriedBy].x = x - xOff(i);
        char[char[i].carriedBy].vx = 0;
    } // end if
} // End of the function
function stopCarrierY(i, y, canCornerHang)
{
    if (ifCarried(i) && (!char[char[i].carriedBy].onob || char[char[i].carriedBy].standingOn >= 0 && char[char[char[i].carriedBy].standingOn].vy != 0))
    {
        if (char[char[i].carriedBy].standingOn >= 0)
        {
            char[char[char[i].carriedBy].standingOn].vy = 0;
            fallOff(char[i].carriedBy);
        } // end if
        if (char[char[i].carriedBy].vy >= 0 && canCornerHang && !solidAt(char[char[i].carriedBy].x, char[i].y + 15))
        {
            var _loc3 = solidAt(char[char[i].carriedBy].x - char[char[i].carriedBy].w - 15, char[i].y + 15) || solidAt(char[char[i].carriedBy].x - char[char[i].carriedBy].w - 45, char[i].y + 15);
            var _loc2 = solidAt(char[char[i].carriedBy].x + char[char[i].carriedBy].w + 15, char[i].y + 15) || solidAt(char[char[i].carriedBy].x + char[char[i].carriedBy].w + 45, char[i].y + 15);
            char[i].justChanged = 2;
            char[char[i].carriedBy].justChanged = 2;
            if (_loc3 && _loc2)
            {
                putDown(char[i].carriedBy);
            }
            else if (_loc3)
            {
                char[char[i].carriedBy].vx = char[char[i].carriedBy].vx + power;
            }
            else if (_loc2)
            {
                char[char[i].carriedBy].vx = char[char[i].carriedBy].vx - power;
            } // end else if
            ++cornerHangTimer;
            if (cornerHangTimer > 30)
            {
                putDown(char[i].carriedBy);
            } // end if
        } // end if
        char[char[i].carriedBy].vy = 0;
        char[char[i].carriedBy].y = y + yOff(i);
        if (newTileDown(char[i].carriedBy) && verticalProp(char[i].carriedBy, 1, 1, char[char[i].carriedBy].x, char[char[i].carriedBy].y))
        {
            char[char[i].carriedBy].y = Math.floor(char[char[i].carriedBy].y / 30) * 30;
        } // end if
    } // end if
} // End of the function
function allSolid(i)
{
    return (blockProperties[i][0] && blockProperties[i][1] && blockProperties[i][2] && blockProperties[i][3]);
} // End of the function
function ifCarried(i)
{
    if (char[i].carriedBy >= 0 && char[i].carriedBy <= 190)
    {
        return (char[char[i].carriedBy].carry);
    }
    else
    {
        return (false);
    } // end else if
} // End of the function
function onlyMovesOneBlock(i, j)
{
    var _loc1 = Math.floor((char[j].dire - 1) / 2) * 2 - 1;
    var _loc3 = Math.ceil(_loc1 * (char[i].x + char[i].w * _loc1) / 30);
    var _loc2 = Math.ceil(_loc1 * (char[control].x + xOff2(control) + char[i].w * _loc1) / 30);
    return (Math.abs(_loc2 - _loc3) <= 1);
} // End of the function
function putDown(i)
{
    if (char[i].carry)
    {
        rippleWeight(i, char[char[i].carryObject].weight2, -1);
        char[i].weight2 = char[i].weight;
        char[char[i].carryObject].weight2 = char[char[i].carryObject].weight;
        char[i].carry = false;
        char[i].justChanged = 2;
        levelChar["char" + char[i].carryObject].swapDepths(charDepth - char[i].carryObject * 2);
        char[char[i].carryObject].carriedBy = -1;
        char[char[i].carryObject].stopMoving();
    } // end if
    cornerHangTimer = 0;
} // End of the function
function charThrow(i)
{
    char[i].weight2 = char[i].weight;
    char[char[i].carryObject].weight2 = char[char[i].carryObject].weight;
    char[char[i].carryObject].vy = -7.500000;
    char[char[i].carryObject].vx = char[i].vx;
    if (char[i].dire <= 2)
    {
        char[char[i].carryObject].vx = char[char[i].carryObject].vx - 3;
    }
    else
    {
        char[char[i].carryObject].vx = char[char[i].carryObject].vx + 3;
    } // end else if
} // End of the function
function fallOff(i)
{
    if (char[i].standingOn >= 0)
    {
        var _loc4 = false;
        if (char[char[i].standingOn].submerged == 1)
        {
            char[char[i].standingOn].submerged = 2;
        }
        else
        {
            rippleWeight(i, char[i].weight2, -1);
        } // end else if
        var _loc3 = char[char[i].standingOn].stoodOnBy.length;
        for (var _loc2 = 0; _loc2 < _loc3; ++_loc2)
        {
            if (char[char[i].standingOn].stoodOnBy[_loc2] == i)
            {
                _loc4 = true;
            } // end if
            if (_loc4 && _loc2 <= _loc3 - 2)
            {
                char[char[i].standingOn].stoodOnBy[_loc2] = char[char[i].standingOn].stoodOnBy[_loc2 + 1];
            } // end if
        } // end of for
        char[char[i].standingOn].stoodOnBy.pop();
        char[i].standingOn = -1;
        char[i].onob = false;
        for (var _loc2 = 0; _loc2 < char[i].stoodOnBy.length; ++_loc2)
        {
            fallOff(char[i].stoodOnBy[_loc2]);
        } // end of for
    } // end if
} // End of the function
function aboveFallOff(i)
{
    if (char[i].stoodOnBy.length >= 1)
    {
        for (var _loc1 = 0; _loc1 < char[i].stoodOnBy.length; ++_loc1)
        {
            fallOff(char[i].stoodOnBy[_loc1]);
        } // end of for
    } // end if
} // End of the function
function rippleWeight(i, w, sign)
{
    if (char[i].standingOn >= 0)
    {
        char[char[i].standingOn].weight2 = char[char[i].standingOn].weight2 + w * sign;
        if (char[char[i].standingOn].submerged == 1 && char[char[i].standingOn].weight2 < 0)
        {
            char[char[i].standingOn].submerged = 2;
        } // end if
        if (char[char[i].standingOn].submerged >= 2 && char[char[i].standingOn].weight2 < 0 && char[char[i].standingOn].onob)
        {
            char[char[i].standingOn].onob = false;
        } // end if
        rippleWeight(char[i].standingOn, w, sign);
    } // end if
} // End of the function
function bounce(i)
{
    if (ifCarried(i))
    {
        bounce(char[i].carriedBy);
    } // end if
    if (char[i].dire % 2 == 0)
    {
        char[i].fricGoal = 0;
    } // end if
    char[i].jump(-jumpPower * 1.660000);
    char[i].onob = false;
    char[i].y = Math.floor(char[i].y / 30) * 30 - 10;
} // End of the function
function landOnObject(i)
{
    var _loc5 = 10000;
    var _loc4 = 0;
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        if (!ifCarried(_loc1) && (char[_loc1].charState == 6 || char[_loc1].charState == 4))
        {
            var _loc3 = Math.abs(char[i].x - char[_loc1].x);
            if (_loc3 < char[i].w + char[_loc1].w && char[i].y >= char[_loc1].y - char[_loc1].h && (char[i].py < char[_loc1].py - char[_loc1].h || char[i].py == char[_loc1].py - char[_loc1].h && char[i].vy == 0))
            {
                if (_loc3 - char[_loc1].w < _loc5)
                {
                    _loc5 = _loc3 - char[_loc1].w;
                    _loc4 = _loc1;
                } // end if
            } // end if
        } // end if
    } // end of for
    if (_loc5 < 10000 && char[i].standingOn != _loc4)
    {
        if (char[i].standingOn >= 0)
        {
            fallOff(i);
        } // end if
        if (char[_loc4].charState == 6 && !char[_loc4].onob)
        {
            char[_loc4].vy = inter(char[_loc4].vy, char[i].vy, char[i].weight2 / (char[_loc4].weight2 + char[i].weight2));
        } // end if
        land(i, char[_loc4].y - char[_loc4].h, char[_loc4].vy);
        if (char[_loc4].onob)
        {
            land2(i, char[_loc4].y - char[_loc4].h);
        } // end if
        char[i].standingOn = _loc4;
        char[_loc4].stoodOnBy.push(i);
        rippleWeight(i, char[i].weight2, 1);
        char[i].fricGoal = char[_loc4].fricGoal;
        if (char[_loc4].submerged == 1 && char[_loc4].weight2 >= 0)
        {
            char[_loc4].submerged = 2;
            char[_loc4].weight2 = char[_loc4].weight2 - 0.160000;
        } // end if
    } // end if
} // End of the function
function objectsLandOn(i)
{
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        if (char[_loc1].charState >= 5 && char[_loc1].standingOn != i)
        {
            var _loc3 = Math.abs(char[i].x - char[_loc1].x);
            if (_loc3 < char[i].w + char[_loc1].w && char[i].y - char[i].h <= char[_loc1].y && char[i].py - char[i].h > char[_loc1].py && (char[i].submerged <= 1 || !char[_loc1].onob || char[_loc1].submerged == 2))
            {
                if (char[_loc1].standingOn >= 0)
                {
                    fallOff(_loc1);
                } // end if
                char[_loc1].standingOn = i;
                char[i].stoodOnBy.push(_loc1);
                land(_loc1, char[i].y - char[i].h, char[_loc1].vy);
                if (char[i].charState == 6)
                {
                    char[i].vy = inter(char[i].vy, char[_loc1].vy, char[_loc1].weight2 / (char[i].weight2 + char[_loc1].weight2));
                } // end if
                char[_loc1].vy = char[i].vy;
                rippleWeight(_loc1, char[_loc1].weight2, 1);
                char[_loc1].fricGoal = char[i].fricGoal;
            } // end if
        } // end if
    } // end of for
} // End of the function
function bumpHead(i)
{
    if (char[i].standingOn >= 0)
    {
        char[i].onob = false;
        char[char[i].standingOn].vy = 0;
        fallOff(i);
    } // end if
} // End of the function
function changeControl()
{
    if (char[control].charState >= 7)
    {
        char[control].stopMoving();
        levelChar["char" + control].swapDepths(charDepth - control * 2);
        if (char[control].carry)
        {
            levelChar["char" + char[control].carry].swapDepths(charDepth - control * 2 + 1);
        } // end if
    } // end if
    control = (control + 1) % charCount;
    for (var _loc1 = 0; char[control].charState != 10 && _loc1 < 10; ++_loc1)
    {
        control = (control + 1) % charCount;
    } // end of for
    if (_loc1 == 10)
    {
        control = 10000;
    } // end if
    if (control < 1000)
    {
        if (ifCarried(control))
        {
            putDown(char[control].carriedBy);
        } // end if
        levelChar["char" + control].swapDepths(charDepth + charCount * 2 - control * 2);
        levelChar["char" + control].burst.gotoAndPlay(2);
    } // end if
} // End of the function
function getCoin(i)
{
    if (!gotThisCoin && char[i].charState >= 7)
    {
        if (Math.floor((char[i].x - char[i].w) / 30) <= locations[2] && Math.ceil((char[i].x + char[i].w) / 30) - 1 >= locations[2] && Math.floor((char[i].y - char[i].h) / 30) <= locations[3] && Math.ceil(char[i].y / 30) - 1 >= locations[3])
        {
            levelActive["tileX" + locations[2] + "Y" + locations[3]].coin.gotoAndPlay(2);
            gotThisCoin = true;
        } // end if
    } // end if
} // End of the function
function startDeath(i)
{
    if (char[i].deathTimer >= 30 && (char[i].charState >= 7 || char[i].temp >= 50))
    {
        if (ifCarried(i))
        {
            char[char[i].carriedBy].vy = 0;
            char[char[i].carriedBy].vx = 0;
            putDown(char[i].carriedBy);
        } // end if
        char[i].pcharState = char[i].charState;
        checkButton2(i, true);
        fallOff(i);
        char[i].deathTimer = 20;
        levelChar["char" + i].leg1.leg.gotoAndStop(50);
        levelChar["char" + i].leg2.leg.gotoAndStop(50);
        levelChar["char" + i].charBody.gotoAndStop(8 + Math.ceil(char[i].dire / 2));
        clearTint(i);
        if (char[i].temp >= 50)
        {
            levelChar["char" + i].fire.gotoAndStop(2);
        } // end if
    } // end if
} // End of the function
function blinkDeath(i)
{
    if (char[i].deathTimer % 6 <= 2)
    {
        levelChar["char" + i]._alpha = 30;
    }
    else
    {
        levelChar["char" + i]._alpha = 100;
    } // end else if
} // End of the function
function endDeath(i)
{
    putDown(i);
    char[i].temp = 0;
    levelChar["char" + i]._visible = false;
    levelChar["char" + i].fire.gotoAndStop(1);
    char[i].charState = 1;
    ++deathCount;
    saveGame();
    if (i == control)
    {
        changeControl();
    } // end if
} // End of the function
function setMovieClipCoordinates(x2, y2)
{
    x = Math.floor(x2);
    y = Math.floor(y2);
    levelShadow._x = x;
    levelShadow._y = y;
    levelStill._x = x;
    levelStill._y = y;
    levelActive._x = x;
    levelActive._y = y;
    levelActive2._x = x;
    levelActive2._y = y;
    levelActive3._x = x;
    levelActive3._y = y;
    levelChar._x = x;
    levelChar._y = y;
    HPRCBubble._x = x;
    HPRCBubble._y = y;
    bg._x = x / 3;
    bg._y = y / 3;
    if (bgXScale > bgYScale)
    {
        bg._y = bg._y - Math.max(0, (bgXScale * 5.400000 - 540) / 2);
    }
    else if (bgYScale > bgSScale)
    {
        bg._x = bg._x - Math.max(0, (bgYScale * 9.600000 - 960) / 2);
    } // end else if
} // End of the function
function setCamera()
{
    if (levelWidth <= 32)
    {
        cameraX = levelWidth * 15 - 480;
    }
    else if (char[control].x - cameraX < 384)
    {
        cameraX = Math.min(Math.max(cameraX + (char[control].x - 384 - cameraX) * 0.120000, 0), levelWidth * 30 - 960);
    }
    else if (char[control].x - cameraX >= 576)
    {
        cameraX = Math.min(Math.max(cameraX + (char[control].x - 576 - cameraX) * 0.120000, 0), levelWidth * 30 - 960);
    } // end else if
    if (levelHeight <= 18)
    {
        cameraY = levelHeight * 15 - 270;
    }
    else if (char[control].y - cameraY < 216)
    {
        cameraY = Math.min(Math.max(cameraY + (char[control].y - 216 - cameraY) * 0.120000, 0), levelHeight * 30 - 540);
    }
    else if (char[control].y - cameraY >= 324)
    {
        cameraY = Math.min(Math.max(cameraY + (char[control].y - 324 - cameraY) * 0.120000, 0), levelHeight * 30 - 540);
    } // end else if
} // End of the function
function near(c1, c2)
{
    var _loc3 = char[c2].y - 23 - (char[c1].y - char[c1].h2 / 2);
    return (Math.abs(_loc3) <= char[c2].h / 2 + char[c1].h2 / 2 && Math.abs(char[c1].x + xOff2(c1) - char[c2].x) < 50);
} // End of the function
function near2(c1, c2)
{
    var _loc2 = char[c2].y - 23 - (char[c1].y - char[c1].h2 / 2);
    return (Math.abs(_loc2) <= 20 && Math.abs(char[c1].x + xOff2(c1) - char[c2].x) < 50);
} // End of the function
function land(i, y, vy)
{
    char[i].y = y;
    if (char[i].weight2 <= 0)
    {
        char[i].vy = -Math.abs(vy);
    }
    else
    {
        char[i].vy = vy;
        char[i].onob = true;
    } // end else if
} // End of the function
function land2(i, y)
{
    char[control].landTimer = 0;
    stopCarrierY(i, y, false);
} // End of the function
function nextDeadPerson(i, dire)
{
    for (i2 = (i + dire + charCount) % charCount; char[i2].charState != 1; i2 = (i2 + dire + charCount) % charCount)
    {
    } // end of for
    return (i2);
} // End of the function
function numberOfDead()
{
    var _loc2 = 0;
    for (var _loc1 = 0; _loc1 < charCount; ++_loc1)
    {
        if (char[_loc1].charState == 1)
        {
            ++_loc2;
        } // end if
    } // end of for
    return (_loc2);
} // End of the function
function recoverCycle(i, dire)
{
    var _loc1 = 0;
    var _loc2 = dire;
    if (dire == 0)
    {
        _loc2 = 1;
    } // end if
    recover2 = (recover2 + _loc2 + charCount) % charCount;
    while ((char[recover2].charState != 1 || char[recover2].pcharState <= 6) && _loc1 < 10)
    {
        recover2 = (recover2 + _loc2 + charCount) % charCount;
        ++_loc1;
    } // end while
    if (_loc1 == 10)
    {
        HPRCBubble.charImage.gotoAndPlay(5);
        recover = false;
        recover2 = 0;
    }
    else if (numberOfDead() == 1)
    {
        HPRCBubble.charImage.gotoAndStop(3);
        HPRCBubble.charImage.anim.charBody.gotoAndStop(char[recover2].id + 1);
    }
    else
    {
        HPRCBubble.charImage.gotoAndStop(4);
        if (dire == 0)
        {
            HPRCBubble.charImage.anim.gotoAndStop(1);
        }
        else
        {
            HPRCBubble.charImage.anim.gotoAndPlay(dire * 8 + 10);
        } // end else if
        HPRCBubble.charImage.anim.charBody.gotoAndStop(char[recover2].id + 1);
        HPRCBubble.charImage.anim.charBody1.gotoAndStop(char[nextDeadPerson(recover2, -1)].id + 1);
        HPRCBubble.charImage.anim.charBody2.gotoAndStop(char[nextDeadPerson(recover2, 1)].id + 1);
    } // end else if
} // End of the function
function setBody(i)
{
    var _loc2;
    var _loc3 = [0, 0];
    if (ifCarried(i) && cornerHangTimer == 0)
    {
        for (var _loc5 = 1; _loc5 <= 2; ++_loc5)
        {
            levelChar["char" + i]["leg" + _loc5].gotoAndStop(Math.floor(char[i].dire / 2 + 0.500000));
            levelChar["char" + i]["leg" + _loc5].leg.gotoAndStop(51);
        } // end of for
        offSetLegs(i, 60);
    }
    else if (char[i].dire % 2 == 0 && char[i].onob)
    {
        if (char[i].standingOn >= 0)
        {
            var _loc4 = char[i].standingOn;
            for (var _loc5 = 1; _loc5 <= 2; ++_loc5)
            {
                levelChar["char" + i]["leg" + _loc5].gotoAndStop(char[i].dire / 2);
                _loc2 = char[i].x + levelChar["char" + i]["leg" + _loc5]._x;
                if (_loc2 >= char[_loc4].x + char[_loc4].w)
                {
                    _loc3[_loc5 - 1] = char[_loc4].x + char[_loc4].w - _loc2;
                    continue;
                } // end if
                if (_loc2 <= char[_loc4].x - char[_loc4].w)
                {
                    _loc3[_loc5 - 1] = char[_loc4].x - char[_loc4].w - _loc2;
                } // end if
            } // end of for
        }
        else if (char[i].fricGoal == 0)
        {
            for (var _loc5 = 1; _loc5 <= 2; ++_loc5)
            {
                levelChar["char" + i]["leg" + _loc5].gotoAndStop(char[i].dire / 2);
                _loc2 = char[i].x + levelChar["char" + i]["leg" + _loc5]._x;
                if (!safeToStandAt(_loc2, char[i].y + 1))
                {
                    var _loc7 = safeToStandAt(_loc2 - 30, char[i].y + 1);
                    var _loc6 = safeToStandAt(_loc2 + 30, char[i].y + 1);
                    if (_loc7 && (!_loc6 || _loc2 % 30 - (_loc5 - 1.500000) * 10 < 30 - _loc2 % 30) && !horizontalProp(i, -1, 1, char[i].x - 15, char[i].y))
                    {
                        _loc3[_loc5 - 1] = -_loc2 % 30;
                    }
                    else if (_loc6 && !horizontalProp(i, 1, 1, char[i].x + 15, char[i].y))
                    {
                        _loc3[_loc5 - 1] = 30 - _loc2 % 30;
                    } // end else if
                    continue;
                } // end if
                _loc3[_loc5 - 1] = 0;
            } // end of for
        } // end else if
        if (_loc3[1] - _loc3[0] >= 41)
        {
            _loc3[0] = _loc3[1];
            _loc3[1] = _loc3[1] - 3;
        } // end if
        var _loc8 = 3 - char[i].dire;
        if (_loc3[0] > _loc3[1] && _loc3[1] >= 0)
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(toFrame(_loc3[0] * _loc8));
            levelChar["char" + i].leg2.leg.gotoAndStop(toFrame(_loc3[0] * _loc8));
        }
        else if (_loc3[0] > _loc3[1] && _loc3[0] <= 0)
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(toFrame(_loc3[1] * _loc8));
            levelChar["char" + i].leg2.leg.gotoAndStop(toFrame(_loc3[1] * _loc8));
        }
        else if (_loc3[0] < 0 && _loc3[1] > 0)
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(toFrame(_loc3[0] * _loc8));
            levelChar["char" + i].leg2.leg.gotoAndStop(toFrame(_loc3[1] * _loc8));
        }
        else if (_loc3[1] > 0 && _loc3[0] == 0)
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(25 + 23 * (3 - char[i].dire));
            levelChar["char" + i].leg2.leg.gotoAndStop(25 + 23 * (3 - char[i].dire));
        }
        else if (_loc3[0] < 0 && _loc3[1] == 0)
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(25 - 23 * (3 - char[i].dire));
            levelChar["char" + i].leg2.leg.gotoAndStop(25 - 23 * (3 - char[i].dire));
        }
        else
        {
            levelChar["char" + i].leg1.leg.gotoAndStop(1);
            levelChar["char" + i].leg2.leg.gotoAndStop(1);
        } // end else if
    }
    else
    {
        for (var _loc5 = 1; _loc5 <= 2; ++_loc5)
        {
            levelChar["char" + i]["leg" + _loc5].gotoAndStop(Math.floor(char[i].dire / 2 + 0.500000));
            if (char[i].submerged >= 1 && !char[i].onob)
            {
                levelChar["char" + i]["leg" + _loc5].leg.gotoAndStop(52);
                continue;
            } // end if
            levelChar["char" + i]["leg" + _loc5].leg.gotoAndStop(50 - char[i].onob);
        } // end of for
        if (char[i].dire % 2 == 1 && char[i].onob)
        {
            offSetLegs(i, 28);
        } // end if
        if (char[i].submerged >= 1 && !char[i].onob)
        {
            offSetLegs(i, 20);
        } // end else if
    } // end else if
    if (cutScene == 1 && dialogueChar[currentLevel][cutSceneLine] == i)
    {
        levelChar["char" + i].charBody.gotoAndStop(Math.ceil(char[i].dire / 2) * 2);
    }
    else if (i == control && recoverTimer >= 1)
    {
        if (char[i].x - (char[HPRC2].x - 33) < 25)
        {
            levelChar["char" + i].charBody.gotoAndStop(Math.ceil(char[i].dire / 2) + 12);
        }
        else
        {
            levelChar["char" + i].charBody.gotoAndStop(Math.ceil(char[i].dire / 2) + 10);
        } // end else if
        drawCrankingArms(i);
    }
    else if (char[i].carry)
    {
        levelChar["char" + i].charBody.gotoAndStop(Math.ceil(char[i].dire / 2) + 6);
    }
    else if (!char[i].onob && !ifCarried(i))
    {
        levelChar["char" + i].charBody.gotoAndStop(Math.ceil(char[i].dire / 2) + 4);
        var _loc9 = Math.round(Math.min(4 - char[i].vy, 15));
    }
    else
    {
        levelChar["char" + i].charBody.gotoAndStop(char[i].dire);
    } // end else if
} // End of the function
function setTint(i)
{
    myColor = new Color(levelChar["char" + i]);
    myColorTransform = new Object();
    var _loc1 = char[i].temp;
    if (char[i].temp > 50)
    {
        _loc1 = 0;
    } // end if
    myColorTransform = {rb: _loc1 * 5.120000, ra: 100 - _loc1, ba: 100 - _loc1, ga: 100 - _loc1};
    myColor.setTransform(myColorTransform);
} // End of the function
function clearTint(i)
{
    myColor = new Color(levelChar["char" + i]);
    myColorTransform = new Object();
    myColorTransform = {rb: 0, ra: 100, ba: 100, ga: 100};
    myColor.setTransform(myColorTransform);
} // End of the function
function toFrame(i)
{
    return (Math.min(Math.max(Math.round(i + 25), 2), 48));
} // End of the function
function offSetLegs(i, duration)
{
    levelChar["char" + i].leg2.leg.leg.gotoAndPlay((levelChar["char" + i].leg1.leg.leg._currentframe + (duration / 2 - 1)) % duration + 1);
} // End of the function
function drawCrankingArms(i)
{
    levelChar["char" + i].charBody.arm1.clear();
    levelChar["char" + i].charBody.arm1.lineStyle(2, 0, 100);
    levelChar["char" + i].charBody.arm1.moveTo(0, 0);
    var _loc3 = -levelChar["char" + i].charBody._x - levelChar["char" + i].charBody.arm1._x + (levelChar["char" + HPRC2]._x - levelChar["char" + i]._x) + levelChar["char" + HPRC2].charBody._x + levelChar["char" + HPRC2].charBody.crank._x * 0.288000 + 10 * Math.cos(3.141593 * recoverTimer / 15 - 0.200000);
    var _loc2 = -levelChar["char" + i].charBody._y - levelChar["char" + i].charBody.arm1._y + (levelChar["char" + HPRC2]._y - levelChar["char" + i]._y) + levelChar["char" + HPRC2].charBody._y + levelChar["char" + HPRC2].charBody.crank._y * 0.288000 + 10 * Math.sin(3.141593 * recoverTimer / 15 - 0.200000);
    levelChar["char" + i].charBody.arm1.lineTo(_loc3, _loc2);
    levelChar["char" + i].charBody.arm1.lineStyle(5, 0, 100);
    levelChar["char" + i].charBody.arm1.lineTo(_loc3, _loc2);
    levelChar["char" + i].charBody.arm1.lineTo(_loc3, _loc2 + 1);
    levelChar["char" + i].charBody.arm2.clear();
    levelChar["char" + i].charBody.arm2.lineStyle(2, 0, 100);
    levelChar["char" + i].charBody.arm2.moveTo(0, 0);
    _loc3 = -levelChar["char" + i].charBody._x - levelChar["char" + i].charBody.arm2._x + (levelChar["char" + HPRC2]._x - levelChar["char" + i]._x) + levelChar["char" + HPRC2].charBody._x + levelChar["char" + HPRC2].charBody.crank._x * 0.288000 + 20 * Math.cos(3.141593 * recoverTimer / 15 - 0.200000);
    _loc2 = -levelChar["char" + i].charBody._y - levelChar["char" + i].charBody.arm2._y + (levelChar["char" + HPRC2]._y - levelChar["char" + i]._y) + levelChar["char" + HPRC2].charBody._y + levelChar["char" + HPRC2].charBody.crank._y * 0.288000 + 20 * Math.sin(3.141593 * recoverTimer / 15 - 0.200000);
    levelChar["char" + i].charBody.arm2.lineTo(_loc3, _loc2);
    levelChar["char" + i].charBody.arm2.lineStyle(5, 0, 100);
    levelChar["char" + i].charBody.arm2.lineTo(_loc3, _loc2);
    levelChar["char" + i].charBody.arm2.lineTo(_loc3, _loc2 + 1);
} // End of the function
function inter(a, b, x)
{
    return (a + (b - a) * x);
} // End of the function
function drawMenu()
{
    _root.attachMovie("menuMovieClip", "menuMovieClip", 0);
    menuMovieClip.menuLevelCreatorGray.gotoAndStop(2);
    menuMovieClip.menuLevelViewerGray.gotoAndStop(2);
    var started = true;
    if (bfdia5b.data.levelProgress == undefined || bfdia5b.data.levelProgress == 0)
    {
        started = false;
    } // end if
    if (!started)
    {
        menuMovieClip.menuContGameGray.gotoAndStop(2);
    } // end if
    menuMovieClip.menuNewGame.onRelease = function ()
    {
        if (started)
        {
            menuMovieClip.menuNewGame._x = menuMovieClip.menuNewGame._x + 1000;
            menuMovieClip.menuNewGame2._x = menuMovieClip.menuNewGame2._x - 1000;
        }
        else
        {
            beginNewGame();
        } // end else if
    };
    menuMovieClip.menuNewGame2.yes.onRelease = function ()
    {
        beginNewGame();
    };
    menuMovieClip.menuNewGame2.no.onRelease = function ()
    {
        menuMovieClip.menuNewGame._x = menuMovieClip.menuNewGame._x - 1000;
        menuMovieClip.menuNewGame2._x = menuMovieClip.menuNewGame2._x + 1000;
    };
    menuMovieClip.menuContGame.onRelease = function ()
    {
        if (started)
        {
            _root.menuMovieClip.removeMovieClip();
            drawLevelMap();
        } // end if
    };
    menuMovieClip.menuWatch.onRelease = function ()
    {
        getURL("http://www.youtube.com/watch?v=4q77g4xo9ic", "_blank");
    };
    menuMovieClip.menuLevelCreator.onRelease = function ()
    {
    };
} // End of the function
function beginNewGame()
{
    clearVars();
    saveGame();
    _root.menuMovieClip.removeMovieClip();
    drawLevelMap();
} // End of the function
function drawLevelMap()
{
    cameraY = 0;
    cameraX = 0;
    _root.attachMovie("levelMap", "levelMap", 2, {_x: 0, _y: 0});
    _root.attachMovie("levelMapBorder", "levelMapBorder", 3);
    levelMapBorder.goBack.onRelease = function ()
    {
        _root.levelMap.removeMovieClip();
        _root.levelMapBorder.removeMovieClip();
        menuScreen = 0;
    };
    levelMapBorder.muteButton2.onRelease = function ()
    {
        if (musicSound.getVolume() == 100)
        {
            musicSound.setVolume(0);
        }
        else
        {
            musicSound.setVolume(100);
        } // end else if
    };
    levelMapBorder.qualButton.onRelease = function ()
    {
        if (_quality == "HIGH")
        {
            setProperty("", _quality, "LOW");
            levelMapBorder.qualMovie.gotoAndPlay(2);
        }
        else
        {
            setProperty("", _quality, "HIGH");
            levelMapBorder.qualMovie.gotoAndPlay(61);
        } // end else if
    };
    levelMap.text1.text = "x " + coins;
    levelMap.text2.text = toHMS(timer);
    levelMap.text3.text = addCommas(deathCount);
    if (levelProgress >= 1)
    {
        levelMap.text4.text = "Minimal deaths to complete level " + levelProgress + ":";
        levelMap.text5.text = mdao[levelProgress - 1];
        levelMap.text6.text = "Unnecessary deaths:";
        levelMap.text7.text = addCommas(deathCount - mdao[levelProgress - 1]);
    } // end if
    for (var _loc3 = 0; _loc3 < 133; ++_loc3)
    {
        var _loc4 = _loc3;
        if (_loc4 >= 100)
        {
            _loc4 = _loc4 + 19;
        } // end if
        levelMap.attachMovie("levelButton", "levelButton" + _loc3, _loc3, {_x: _loc4 % 8 * 110 + 45, _y: Math.floor(_loc4 / 8) * 50 + 160});
        if (gotCoin[_loc3])
        {
            levelMap["levelButton" + _loc3].gotoAndStop(4);
        }
        else if (levelProgress == _loc3)
        {
            levelMap["levelButton" + _loc3].gotoAndStop(2);
        }
        else if (levelProgress > _loc3)
        {
            levelMap["levelButton" + _loc3].gotoAndStop(3);
        }
        else
        {
            levelMap["levelButton" + _loc3].gotoAndStop(1);
        } // end else if
        levelMap["levelButton" + _loc3].id = _loc3;
        if (_loc3 >= 100)
        {
            levelMap["levelButton" + _loc3].textie.text = "B" + numberToText(_loc3 - 99, false);
        }
        else
        {
            levelMap["levelButton" + _loc3].textie.text = numberToText(_loc3 + 1, true);
        } // end else if
        levelMap["levelButton" + _loc3].onRollOver = function ()
        {
            if (this.id <= levelProgress)
            {
                levelMap["levelButton" + this.id].mov.gotoAndStop(2);
            } // end if
			if (this.id < levelProgress)
			{
				levelMap["levelButton" + this.id].textie.text = "";
				levelMap["levelButton" + this.id].bestTime.text = toHMS(bfdia5b.data.best[this.id]);
			}
        };
        levelMap["levelButton" + _loc3].onRollOut = function ()
        {
            levelMap["levelButton" + this.id].mov.gotoAndStop(1);
			if (this.id < levelProgress)
			{
				if (this.id >= 100)
        		{
            		levelMap["levelButton" + this.id].textie.text = "B" + numberToText(this.id - 99, false);
        		}
        		else
        		{
            		levelMap["levelButton" + this.id].textie.text = numberToText(this.id + 1, true);
        		} // end else if
				levelMap["levelButton" + this.id].bestTime.text = "";
			}
        };
        levelMap["levelButton" + _loc3].onReleaseOutside = function ()
        {
            levelMap["levelButton" + this.id].mov.gotoAndStop(1);
			if (this.id < levelProgress)
			{
				if (this.id >= 100)
        		{
            		levelMap["levelButton" + this.id].textie.text = "B" + numberToText(this.id - 99, false);
        		}
        		else
        		{
            		levelMap["levelButton" + this.id].textie.text = numberToText(this.id + 1, true);
        		} // end else if
				levelMap["levelButton" + this.id].bestTime.text = "";
			}
        };
        levelMap["levelButton" + _loc3].onPress = function ()
        {
            if (this.id <= levelProgress)
            {
                levelMap["levelButton" + this.id].mov.gotoAndStop(3);
            } // end if
        };
        levelMap["levelButton" + _loc3].onRelease = function ()
        {
            if (this.id <= levelProgress)
            {
                playLevel(this.id);
                _root.levelMap.removeMovieClip();
                _root.levelMapBorder.removeMovieClip();
                white._alpha = 100;
            } // end if
        };
    } // end of for
    menuScreen = 2;
} // End of the function
function addCommas(i)
{
    var _loc4 = String(i);
    var _loc2 = "";
    var _loc3 = _loc4.length;
    for (var _loc1 = 0; _loc1 < _loc3; ++_loc1)
    {
        if ((_loc3 - _loc1) % 3 == 0 && _loc1 != 0)
        {
            _loc2 = _loc2 + ",";
        } // end if
        _loc2 = _loc2 + _loc4.charAt(_loc1);
    } // end of for
    return (_loc2);
} // End of the function
function calcDist(i)
{
    return (Math.sqrt(Math.pow(char[i].x - locations[2] * 30 + 15, 2) + Math.pow(char[i].y - char[i].h / 2 - locations[3] * 30 + 15, 2)));
} // End of the function
function drawLevelCreator()
{
    _root.attachMovie("levelCreator", "levelCreator", 0, {_x: 0, _y: 0});
    levelCreator.createEmptyMovieClip("grid", 100);
    levelCreator.createEmptyMovieClip("tiles", 98);
    levelCreator.createEmptyMovieClip("rectSelect", 99);
    menuScreen = 5;
    selectedTab = 0;
    levelWidth = 32;
    tool = 0;
    levelHeight = 18;
    clearMyWholeLevel();
    drawLCGrid();
    fillTilesTab();
    charCount2 = 0;
    charCount = 0;
    setEndGateLights();
    LCEndGateX = -1;
    LCEndGateY = -1;
    levelCreator.sideBar.tab1.gotoAndStop(1);
    for (var _loc2 = 0; _loc2 < 10; ++_loc2)
    {
        levelCreator.tools["tool" + _loc2].gotoAndStop(2);
    } // end of for
    levelCreator.tools.tool9.gotoAndStop(1);
} // End of the function
function setTool(i)
{
    levelCreator.tools["tool" + tool].gotoAndStop(2);
    tool = i;
    if (tool == 2 || tool == 5)
    {
        clearRectSelect();
    } // end if
    levelCreator.tools["tool" + tool].gotoAndStop(1);
} // End of the function
function clearRectSelect()
{
    levelCreator.rectSelect.clear();
    LCRect = [-1, -1, -1, -1];
} // End of the function
function fillTilesTab()
{
    levelCreator.sideBar.tab4.createEmptyMovieClip("tiles", 1);
    for (var _loc1 = 0; _loc1 < tileCount; ++_loc1)
    {
        levelCreator.sideBar.tab4.tiles.attachMovie("LEtile3", "tile" + _loc1, _loc1, {_x: _loc1 % 5 * 60 + 15, _y: Math.floor(_loc1 / 5) * 60 + 55});
        levelCreator.sideBar.tab4.tiles["tile" + _loc1].gotoAndStop(_loc1 + 1);
    } // end of for
    levelCreator.sideBar.tab4.attachMovie("burst1", "selector", 0, {_x: 30, _y: 70, _xscale: 100, _yscale: 75});
    setSelectedTile(1000);
} // End of the function
function setSelectedTile(i)
{
    selectedTile = i;
    var _loc3 = i % 5 * 60 + 30;
    var _loc2 = Math.floor(i / 5) * 60 + 70;
    levelCreator.sideBar.tab4.selector._x = _loc3;
    levelCreator.sideBar.tab4.selector._y = _loc2;
} // End of the function
function setEndGateLights()
{
    levelCreator.sideBar.tab4.tiles.tile6.light.gotoAndStop(charCount + 1);
    if (LCEndGateX >= 0)
    {
        levelCreator.tiles["tileX" + LCEndGateX + "Y" + LCEndGateY].light.gotoAndStop(charCount + 1);
    } // end if
} // End of the function
function clearMyWholeLevel()
{
    myLevel = new Array(3);
    for (var _loc1 = 0; _loc1 < 3; ++_loc1)
    {
        clearMyLevel(_loc1);
    } // end of for
} // End of the function
function clearMyLevel(i)
{
    myLevel[i] = new Array(levelHeight);
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        myLevel[i][_loc2] = new Array(levelWidth);
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            myLevel[i][_loc2][_loc1] = 0;
        } // end of for
    } // end of for
} // End of the function
function drawLCGrid()
{
    scale = Math.min(640 / levelWidth, 460 / levelHeight);
    levelCreator.grid.lineStyle(scale / 9, 0, 50);
    for (var _loc1 = 0; _loc1 <= levelWidth; ++_loc1)
    {
        levelCreator.grid.moveTo(330 - scale * levelWidth / 2 + _loc1 * scale, 240 - scale * levelHeight / 2);
        levelCreator.grid.lineTo(330 - scale * levelWidth / 2 + _loc1 * scale, 240 + scale * levelHeight / 2);
    } // end of for
    for (var _loc1 = 0; _loc1 <= levelHeight; ++_loc1)
    {
        levelCreator.grid.moveTo(330 - scale * levelWidth / 2, 240 - scale * levelHeight / 2 + _loc1 * scale);
        levelCreator.grid.lineTo(330 + scale * levelWidth / 2, 240 - scale * levelHeight / 2 + _loc1 * scale);
    } // end of for
    addLCTiles();
    updateLCTiles();
} // End of the function
function clearLCGrid()
{
    levelCreator.grid.clear();
    removeLCTiles();
} // End of the function
function addLCTiles()
{
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            var _loc4 = 330 - scale * levelWidth / 2 + _loc1 * scale;
            var _loc3 = 240 - scale * levelHeight / 2 + _loc2 * scale;
            levelCreator.tiles.attachMovie("LEtile2", "tileX" + _loc1 + "Y" + _loc2, _loc2 * levelWidth + _loc1, {_x: _loc4, _y: _loc3, _xscale: scale * 100 / 30, _yscale: scale * 100 / 30});
            levelCreator.tiles["tileX" + _loc1 + "Y" + _loc2].gotoAndStop(myLevel[1][_loc2][_loc1] + 1);
        } // end of for
    } // end of for
} // End of the function
function removeLCTiles()
{
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            levelCreator.tiles["tileX" + _loc1 + "Y" + _loc2].removeMovieClip();
        } // end of for
    } // end of for
} // End of the function
function updateLCtiles()
{
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            levelCreator.tiles["tileX" + _loc1 + "Y" + _loc2].gotoAndStop(myLevel[1][_loc2][_loc1] + 1);
        } // end of for
    } // end of for
} // End of the function
function fillTile(x, y, after, before)
{
    var _loc4 = [[x, y]];
    while (_loc4.length >= 1)
    {
        for (var _loc1 = 0; _loc1 < 4; ++_loc1)
        {
            if (_loc1 == 3 && x == levelWidth - 1 || _loc1 == 2 && x == 0 || _loc1 == 1 && y == levelHeight - 1 || _loc1 == 0 && y == 0)
            {
                continue;
            } // end if
            var _loc3 = _loc4[0][0] + cardinal[_loc1][0];
            var _loc2 = _loc4[0][1] + cardinal[_loc1][1];
            if (myLevel[1][_loc2][_loc3] == before)
            {
                _loc4.push([_loc3, _loc2]);
                myLevel[1][_loc2][_loc3] = after;
                levelCreator.tiles["tileX" + _loc3 + "Y" + _loc2].gotoAndStop(after + 1);
            } // end if
        } // end of for
        _loc4.shift();
    } // end while
} // End of the function
function setSelectedTab(i)
{
    selectedTab = i;
    if (i == 0)
    {
        setTexties();
    }
    else
    {
        setTexties2();
    } // end else if
} // End of the function
function setTexties()
{
    for (var _loc1 = 1; _loc1 <= 3; ++_loc1)
    {
        levelCreator.sideBar.tab1["textie" + _loc1].selectable = true;
    } // end of for
} // End of the function
function setTexties2()
{
    for (var _loc1 = 1; _loc1 <= 3; ++_loc1)
    {
        levelCreator.sideBar.tab1["textie" + _loc1].selectable = false;
    } // end of for
} // End of the function
function setUndo()
{
    LCSwapLevelData(1, 0);
    undid = false;
    levelCreator.tools.tool9.gotoAndStop(1);
} // End of the function
function undo()
{
    LCSwapLevelData(1, 2);
    LCSwapLevelData(0, 1);
    LCSwapLevelData(2, 0);
    if (undid)
    {
        levelCreator.tools.tool9.gotoAndStop(1);
    }
    else
    {
        levelCreator.tools.tool9.gotoAndStop(2);
    } // end else if
    undid = !undid;
} // End of the function
function LCSwapLevelData(a, b)
{
    myLevel[b] = new Array(myLevel[a].length);
    for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
    {
        myLevel[b][_loc2] = new Array(myLevel[a][0].length);
        for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
        {
            myLevel[b][_loc2][_loc1] = myLevel[a][_loc2][_loc1];
            if (b == 1)
            {
                levelCreator.tiles["tileX" + _loc1 + "Y" + _loc2].gotoAndStop(myLevel[b][_loc2][_loc1] + 1);
            } // end if
        } // end of for
    } // end of for
} // End of the function
function drawLCRect(x1, y1, x2, y2)
{
    levelCreator.rectSelect.clear();
    levelCreator.rectSelect.lineStyle(1, 0, 0);
    levelCreator.rectSelect.beginFill(16776960, 50);
    levelCreator.rectSelect.moveTo(x1 * scale + (330 - scale * levelWidth / 2), y1 * scale + (240 - scale * levelHeight / 2));
    levelCreator.rectSelect.lineTo((x2 + 1) * scale + (330 - scale * levelWidth / 2), y1 * scale + (240 - scale * levelHeight / 2));
    levelCreator.rectSelect.lineTo((x2 + 1) * scale + (330 - scale * levelWidth / 2), (y2 + 1) * scale + (240 - scale * levelHeight / 2));
    levelCreator.rectSelect.lineTo(x1 * scale + (330 - scale * levelWidth / 2), (y2 + 1) * scale + (240 - scale * levelHeight / 2));
    levelCreator.rectSelect.lineTo(x1 * scale + (330 - scale * levelWidth / 2), y1 * scale + (240 - scale * levelHeight / 2));
    levelCreator.rectSelect.endFill();
} // End of the function
function closeToEdgeY()
{
    var _loc1 = (_ymouse - (240 - scale * levelHeight / 2)) / scale % 1;
    return (Math.abs(_loc1 - 0.500000) > 0.250000);
} // End of the function
function closeToEdgeX()
{
    var _loc1 = (_xmouse - (330 - scale * levelWidth / 2)) / scale % 1;
    return (Math.abs(_loc1 - 0.500000) > 0.250000);
} // End of the function
function playLevel(i)
{
    if (i == levelProgress)
    {
        playMode = 0;
    }
    else if (i < levelProgress)
    {
        playMode = 1;
    } // end else if
    currentLevel = i;
    wipeTimer = 30;
    _root.attachMovie("csBubble", "csBubble", 8);
    _root.createEmptyMovieClip("HPRCBubble", 7);
    _root.createEmptyMovieClip("levelChar", 5);
    addTileMovieClips();
    _root.attachMovie("bg", "bg", 0);
    levelStill.cacheAsBitmap = true;
    levelStill.cacheAsBitmap = true;
    levelShadow.cacheAsBitmap = true;
    bg.cacheAsBitmap = true;
    menuScreen = 3;
    _root.attachMovie("levelButtons", "levelButtons", 9);
    toSeeCS = true;
    transitionType = 1;
    resetLevel();
    levelButtons.levelMapButton.onRelease = function ()
    {
        timer = timer + (getTimer() - levelTimer2);
        saveGame();
        exitLevel();
    };
	
	if (bfdia5b.data.best[i]) {
    	levelButtons.levelBestTime.text = toHMS(bfdia5b.data.best[i]);
	}
} // End of the function
function addTileMovieClips()
{
    _root.createEmptyMovieClip("levelActive3", 6);
    _root.createEmptyMovieClip("levelActive2", 4);
    _root.createEmptyMovieClip("levelShadow", 3);
    _root.createEmptyMovieClip("levelActive", 2);
    _root.createEmptyMovieClip("levelStill", 1);
} // End of the function
function removeTileMovieClips()
{
    _root.levelActive.removeMovieClip();
    _root.levelStill.removeMovieClip();
    _root.levelActive2.removeMovieClip();
    _root.levelActive3.removeMovieClip();
    _root.levelShadow.removeMovieClip();
} // End of the function
function exitLevel()
{
    _root.csBubble.removeMovieClip();
    removeTileMovieClips();
    _root.levelChar.removeMovieClip();
    _root.bg.removeMovieClip();
    _root.levelButtons.removeMovieClip();
    drawLevelMap();
} // End of the function
function mouseOnGrid()
{
    return (_xmouse >= 330 - scale * levelWidth / 2 && _xmouse <= 330 + scale * levelWidth / 2 && _ymouse >= 240 - scale * levelHeight / 2 && _ymouse <= 240 + scale * levelHeight / 2);
} // End of the function
function mouseOnScreen()
{
    return (_xmouse < 660 && _ymouse < 480);
} // End of the function
var musicSound = new Sound();
musicSound.attachSound("music");
musicSound.start(0, 12345);
var blockProperties = [[false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [true, true, true, true, true, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, true, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, true, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, true, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, true, true, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, true, true, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 6, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 6, false, false], [true, true, true, true, true, true, true, true, false, false, false, 0, 0, false, false], [false, true, false, false, false, false, false, false, false, true, false, 0, 0, false, false], [true, true, true, true, true, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, true, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, true, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, true, false, false, false, 0, 0, false, false], [true, true, true, true, true, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 1, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 1, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 1, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 1, false, false], [false, false, false, false, false, false, false, false, true, false, false, 1, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 7, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 2, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 8, 0, false, false], [false, true, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 13, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 14, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, true, false, false, false, false, false, false, true, false, 0, 0, false, false], [true, true, true, true, false, true, false, true, false, false, false, 0, 0, false, false], [true, true, true, true, false, true, true, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 2, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 2, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 2, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 2, false, false], [false, true, false, false, false, false, false, false, false, true, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 3, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 9, 0, false, false], [false, false, false, false, false, false, false, false, true, true, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 3, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 3, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 3, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 3, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 3, false, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 3, false, false], [false, false, false, false, false, false, false, false, true, true, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, true, false, false, false, false, false, false, false, 0, 0, false, false], [true, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, true, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, true, false, false, 15, 0, false, false], [true, true, true, true, true, true, true, true, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [true, true, true, true, false, false, false, false, true, false, false, 0, 0, false, false], [false, false, false, false, true, true, true, true, true, false, false, 0, 0, false, false], [false, false, false, false, true, true, true, true, true, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 1, false, false], [true, true, true, true, true, true, true, true, true, false, false, 0, 1, false, false], [false, false, false, false, false, false, false, false, true, true, false, 0, 0, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 1, false, false], [false, false, false, false, false, false, false, false, true, false, false, 0, 1, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 6, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 6, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 6, false, false], [false, true, false, false, false, false, false, false, true, false, false, 0, 6, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, true, true, true, true, false, false, false, 0, 1, false, true], [false, false, false, false, false, false, false, false, true, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, true, true, true, true, false, false, false, 0, 1, false, true], [false, false, false, false, false, false, false, false, true, false, false, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, true, false, false, 6, 0, false, false], [false, false, false, false, false, false, false, false, true, false, false, 12, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false], [false, false, false, false, false, false, false, false, false, false, false, 0, 1, false, true], [true, true, true, true, false, false, false, false, false, false, false, 0, 0, true, false], [false, false, false, false, false, false, false, false, false, false, true, 0, 0, false, false]];
var switches = [[31, 33, 32, 34, 79, 78, 81, 82], [51, 53, 52, 54], [65, 61, 60, 62, 63, 64], [], [], [14, 16, 83, 85]];
var charD = [[28, 45.400000, 0.450000, 27, 0.800000, false, 1], [23, 56, 0.360000, 31, 0.800000, false, 1.700000], [20, 51, 0.410000, 20, 0.850000, false, 5], [10, 86, 0.260000, 31, 0.800000, false, 1.600000], [10, 84, 0.230000, 31, 0.800000, false, 1.400000], [28, 70, 0.075000, 28, 0.800000, false, 9], [26, 49, 0.200000, 20, 0.750000, false, 0.600000], [44, 65, 0.800000, 20, 0.750000, false, 0.800000], [16, 56, 0.250000, 17, 0.760000, false, 0.800000], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [0, 0, 0, 0, 0, false], [36.500000, 72.800000, 1, 20, 0.600000, false, 0], [15.100000, 72.800000, 0.600000, 20, 0.700000, true, 0], [20, 40, 0.150000, 20, 0.700000, true, 0.700000], [25, 50, 0.640000, 20, 0.600000, true, 0.100000], [25, 10, 1, 0, 0.700000, true, 0.200000], [25, 50, 1, 20, 0.700000, true, 0.100000], [25, 29, 0.100000, 20, 0.800000, true, 1], [21.500000, 43, 0.300000, 20, 0.600000, true, 0.500000], [35, 60, 1, 20, 0.700000, true, 0.100000], [22.500000, 45, 1, 20, 0.700000, true, 0.800000], [25, 50, 1, 0, 0.700000, true, 0.100000], [15, 30, 0.640000, 20, 0.600000, true, 0.200000], [10, 55, 0.800000, 0, 0.300000, true, 0.400000], [45, 10, 1, 0, 0.700000, true, 0.200000], [20, 40, 1, 0, 0.800000, false, 0.800000], [16, 45, 0.400000, 20, 0.940000, false, 1.100000], [25, 10, 1, 0, 0.700000, true, 0.300000], [45, 10, 0.400000, 0, 0.700000, true, 0.700000], [15, 50, 0.100000, 0, 0.800000, true, 1.900000], [25, 25, 0.100000, 0, 0.800000, true, 1.700000], [30, 540, 10, 10, 0.400000, true, 0]];
var names = ["Ruby", "Book", "Ice Cube", "Match", "Pencil", "Bubble"];
var selectedTab = 0;
var power = 1;
var jumpPower = 11;
var qPress = false;
var upPress = false;
var csPress = false;
var downPress = false;
var leftPress = false;
var rightPress = false;
var recover = false;
var recover2 = 0;
var recoverTimer = 0;
var HPRC2 = 0;
var cornerHangTimer = 0;
var goal = 0;
var charsAtEnd = 0;
var qPressTimer = 0;
var transitionType = 1;
var char = new Array(1);
var currentLevel = -1;
var control = 0;
var wipeTimer = 30;
var cutScene = 0;
var cutSceneLine = 0;
var bubWidth = 500;
var bubHeight = 100;
var bubMargin = 40;
var charDepth = 0;
var levelWidth = 0;
var levelHeight = 0;
var cameraX = 0;
var cameraY = 0;
var menuScreen = 0;
var myLevel;
var scale = 20;
var tool = 0;
var selectedTile = 0;
var mouseIsDown = false;
var LCEndGateX = 0;
var LCEndGateY = 0;
var cardinal = [[0, -1], [0, 1], [-1, 0], [1, 0]];
var diagonal = [[-1, -1], [1, -1], [1, 1], [-1, 1]];
var diagonal2 = [[0, 2], [0, 3], [1, 2], [1, 3]];
var undid = false;
var LCRect = [-1, -1, -1, -1];
var levelTimer = 0;
var levelTimer2 = 0;
var bgXScale = 0;
var bgYscale = 0;
var stopX = 0;
var stopY = 0;
var toBounce = false;
var toSeeCS = true;
var tDown = false;
_root.attachMovie("white", "white", 10, {_alpha: 0});
onEnterFrame = function ()
{
    levelButtons.levelTimer.text = toHMS(getTimer() - levelTimer2);
	
	if (!bfdia5b.data.best[currentLevel]) {
		levelButtons.levelBestTime.text = toHMS(getTimer() - levelTimer2);
	}
	
	levelButtons.levelTotalTime.text = toHMS(timer + (getTimer() - levelTimer2));
	
	if (bfdia5b.data.hideTimer)
	{
		levelButtons.timerText._visible = false;
		levelButtons.bestText._visible = false;
		levelButtons.totalText._visible = false;
		levelButtons.levelTimer._visible = false;
		levelButtons.levelBestTime._visible = false;
		levelButtons.levelTotalTime._visible = false;
	}
	
	if (Key.isDown(84) && !tDown)
	{
		tDown = true;
		
		if (levelButtons.timerText._visible)
		{
			levelButtons.timerText._visible = false;
			levelButtons.bestText._visible = false;
			levelButtons.totalText._visible = false;
			levelButtons.levelTimer._visible = false;
			levelButtons.levelBestTime._visible = false;
			levelButtons.levelTotalTime._visible = false;
			
			bfdia5b.data.hideTimer = true;
			bfdia5b.flush();
		}
		else
		{
			levelButtons.timerText._visible = true;
			levelButtons.bestText._visible = true;
			levelButtons.totalText._visible = true;
			levelButtons.levelTimer._visible = true;
			levelButtons.levelBestTime._visible = true;
			levelButtons.levelTotalTime._visible = true;
			
			bfdia5b.data.hideTimer = false;
			bfdia5b.flush();
		}
	}
	
	if (!Key.isDown(84))
	{
		tDown = false;
	}
	
    if (menuScreen == 0)
    {
        drawMenu();
        menuScreen = 1;
    } // end if
    if (menuScreen == 2)
    {
        if (_xmouse < 587 || _ymouse < 469)
        {
            if (_ymouse <= 180)
            {
                cameraY = Math.min(Math.max(cameraY - (180 - _ymouse) * 0.100000, 0), 1080);
            }
            else if (_ymouse >= 360)
            {
                cameraY = Math.min(Math.max(cameraY + (_ymouse - 360) * 0.100000, 0), 1080);
            } // end else if
            levelMap._y = -cameraY;
        } // end if
    } // end if
    if (menuScreen == 3 || menuScreen == 4)
    {
        if (wipeTimer == 30)
        {
            if (transitionType == 0)
            {
                resetLevel();
            }
            else if (menuScreen == 4 && charsAtEnd >= charCount2)
            {
                if (gotThisCoin && !gotCoin[currentLevel])
                {
                    gotCoin[currentLevel] = true;
                    ++coins;
                } // end if
                timer = timer + (getTimer() - levelTimer2);
				
				if ((!bfdia5b.data.best[currentLevel]) || (bfdia5b.data.best[currentLevel] > (getTimer() - levelTimer2))) {
					best[currentLevel] = getTimer() - levelTimer2;
				}
				
                if (playMode == 0)
                {
                    ++currentLevel;
                    levelProgress = currentLevel;
                    resetLevel();
                }
                else
                {
                    exitLevel();
                } // end else if
                saveGame();
            } // end if
        } // end else if
        if (menuScreen == 3)
        {
            menuScreen = 4;
        } // end if
        if (cutScene == 1 || cutScene == 2)
        {
            if (Key.isDown(13) || Key.isDown(16))
            {
                if (!csPress && cutScene == 1)
                {
                    ++cutSceneLine;
                    if (cutSceneLine >= dialogueChar[currentLevel].length)
                    {
                        endCutScene();
                    }
                    else
                    {
                        displayLine(currentLevel, cutSceneLine);
                    } // end if
                } // end else if
                csPress = true;
            }
            else
            {
                csPress = false;
                if (cutScene == 2)
                {
                    cutScene = 3;
                } // end if
            } // end else if
        }
        else
        {
            if (levelChar["char" + control].burst._currentframe == 2)
            {
                levelChar["char" + control].burst.play();
            } // end if
            if (recover)
            {
                char[control].justChanged = 2;
                if (recoverTimer == 0)
                {
                    if (Key.isDown(37))
                    {
                        if (!leftPress)
                        {
                            recoverCycle(HPRC2, -1);
                        } // end if
                        leftPress = true;
                    }
                    else
                    {
                        leftPress = false;
                    } // end else if
                    if (Key.isDown(39))
                    {
                        if (!rightPress)
                        {
                            recoverCycle(HPRC2, 1);
                        } // end if
                        rightPress = true;
                    }
                    else
                    {
                        rightPress = false;
                    } // end if
                } // end else if
            }
            else
            {
                if (cornerHangTimer == 0)
                {
                    if (Key.isDown(37))
                    {
                        char[control].moveHorizontal(-power);
                    }
                    else if (Key.isDown(39))
                    {
                        char[control].moveHorizontal(power);
                    } // end if
                } // end else if
                if (!Key.isDown(37) && !Key.isDown(39))
                {
                    char[control].stopMoving();
                } // end if
            } // end else if
            if (Key.isDown(38))
            {
                if (!upPress)
                {
                    if (recover && recoverTimer == 0)
                    {
                        recoverTimer = 60;
                        char[recover2].charState = 2;
                        char[recover2].x = char[HPRC1].x;
                        char[recover2].y = char[HPRC1].y - 20;
                        char[recover2].vx = 0;
                        char[recover2].vy = -1;
                        levelChar["char" + recover2]._x = char[recover2].x;
                        levelChar["char" + recover2]._y = char[recover2].y;
                        levelChar["char" + recover2].charBody.gotoAndStop(4);
                        levelChar["char" + recover2]._visible = true;
                        if (char[recover2].id == 5)
                        {
                            levelChar["char" + recover2].leg1._visible = true;
                            levelChar["char" + recover2].leg2._visible = true;
                        } // end if
                        levelChar["char" + recover2].leg1.gotoAndStop(2);
                        levelChar["char" + recover2].leg2.gotoAndStop(2);
                        levelChar["char" + recover2]._alpha = 100;
                        HPRCBubble.charImage.gotoAndStop(1);
                        goal = Math.round(char[HPRC1].x / 30) * 30;
                    }
                    else if (char[control].id != 2 && !recover && char[control].deathTimer >= 30)
                    {
                        if (char[control].carry)
                        {
                            putDown(control);
                            charThrow(control);
                        }
                        else
                        {
                            for (var _loc2 = 0; _loc2 < charCount; ++_loc2)
                            {
                                if (_loc2 != control && near(control, _loc2) && char[_loc2].charState >= 6 && char[control].standingOn != _loc2 && onlyMovesOneBlock(_loc2, control))
                                {
                                    if (char[_loc2].carry)
                                    {
                                        putDown(_loc2);
                                    } // end if
                                    if (ifCarried(_loc2))
                                    {
                                        putDown(char[_loc2].carriedBy);
                                    } // end if
                                    char[control].carry = true;
                                    char[control].carryObject = _loc2;
                                    levelChar["char" + _loc2].swapDepths(charDepth + charCount * 2 - control * 2 + 1);
                                    char[_loc2].carriedBy = control;
                                    char[_loc2].weight2 = char[_loc2].weight;
                                    char[control].weight2 = char[_loc2].weight + char[control].weight;
                                    rippleWeight(control, char[_loc2].weight2, 1);
                                    fallOff(_loc2);
                                    aboveFallOff(_loc2);
                                    char[_loc2].justChanged = 2;
                                    char[control].justChanged = 2;
                                    if (char[_loc2].submerged == 1)
                                    {
                                        char[_loc2].submerged = 0;
                                    } // end if
                                    if (char[_loc2].onob && char[control].y - char[_loc2].y > yOff(_loc2))
                                    {
                                        char[control].y = char[_loc2].y + yOff(_loc2);
                                        char[control].onob = false;
                                        char[_loc2].onob = true;
                                    } // end if
                                    break;
                                } // end if
                            } // end of for
                        } // end if
                    } // end else if
                } // end else if
                upPress = true;
            }
            else
            {
                upPress = false;
            } // end else if
            if (Key.isDown(40))
            {
                if (!downPress)
                {
                    if (char[control].carry)
                    {
                        putDown(control);
                    }
                    else if (recover)
                    {
                        if (recoverTimer == 0)
                        {
                            recover = false;
                            HPRCBubble.charImage.gotoAndStop(1);
                        } // end if
                    }
                    else if (near2(control, HPRC2) && char[control].id != 2 && char[control].onob)
                    {
                        char[control].stopMoving();
                        if (char[control].x >= char[HPRC2].x - 33)
                        {
                            char[control].dire = 2;
                        }
                        else
                        {
                            char[control].dire = 4;
                        } // end else if
                        recover = true;
                        recover2 = charCount - 1;
                        recoverCycle(HPRC2, 0);
                    } // end else if
                } // end else if
                downPress = true;
            }
            else
            {
                downPress = false;
            } // end else if
            if (Key.isDown(90))
            {
                if (!qPress && !recover)
                {
                    changeControl();
                    qTimer = 6;
                } // end if
                qPress = true;
            }
            else
            {
                qPress = false;
            } // end else if
            if (Key.isDown(32))
            {
                if ((char[control].onob || char[control].submerged == 3) && char[control].landTimer > 2 && !recover)
                {
                    if (char[control].submerged == 3)
                    {
                        char[control].swimUp(0.140000 / char[control].weight2);
                    }
                    else
                    {
                        char[control].jump(-jumpPower);
                    } // end else if
                    char[control].onob = false;
                    fallOff(control);
                } // end if
            }
            else
            {
                char[control].landTimer = 80;
            } // end else if
        } // end else if
        if (Key.isDown(82) && wipeTimer == 0)
        {
            wipeTimer = 1;
            transitionType = 0;
            if (cutScene == 1)
            {
                csBubble.gotoAndPlay(17);
            } // end if
        } // end if
        locations[4] = 1000;
        for (var _loc2 = 0; _loc2 < charCount; ++_loc2)
        {
            if (char[_loc2].charState >= 5)
            {
                ++char[_loc2].landTimer;
                if (char[_loc2].carry && char[char[_loc2].carryObject].justChanged < char[_loc2].justChanged)
                {
                    char[char[_loc2].carryObject].justChanged = char[_loc2].justChanged;
                } // end if
                if (char[_loc2].standingOn == -1)
                {
                    if (char[_loc2].onob)
                    {
                        if (char[_loc2].charState >= 5)
                        {
                            char[_loc2].fricGoal = onlyConveyorsUnder(_loc2);
                        } // end if
                    } // end if
                }
                else
                {
                    char[_loc2].fricGoal = char[char[_loc2].standingOn].vx;
                } // end else if
                char[_loc2].applyForces(char[_loc2].weight2, control == _loc2, jumpPower * 0.700000);
                if (char[_loc2].deathTimer >= 30)
                {
                    char[_loc2].charMove();
                } // end if
                if (char[_loc2].id == 3)
                {
                    if (char[_loc2].temp > 50)
                    {
                        levelChar["char" + _loc2].fire.gotoAndStop(2);
                        for (var _loc4 = 0; _loc4 < charCount; ++_loc4)
                        {
                            if (char[_loc4].charState >= 5 && _loc4 != _loc2)
                            {
                                if (Math.abs(char[_loc2].x - char[_loc4].x) < char[_loc2].w + char[_loc4].w && char[_loc4].y > char[_loc2].y - char[_loc2].h && char[_loc4].y < char[_loc2].y + char[_loc4].h)
                                {
                                    char[_loc4].heated = 2;
                                    heat(_loc4);
                                } // end if
                            } // end if
                        } // end of for
                    }
                    else
                    {
                        levelChar["char" + _loc2].fire.gotoAndStop(1);
                    } // end if
                } // end else if
            }
            else if (char[_loc2].charState >= 3)
            {
                var _loc8 = Math.floor(levelTimer / char[_loc2].speed) % (startLocations[currentLevel][_loc2][6].length - 2);
                char[_loc2].vx = cardinal[startLocations[currentLevel][_loc2][6][_loc8 + 2]][0] * (30 / char[_loc2].speed);
                char[_loc2].vy = cardinal[startLocations[currentLevel][_loc2][6][_loc8 + 2]][1] * (30 / char[_loc2].speed);
                char[_loc2].px = char[_loc2].x;
                char[_loc2].py = char[_loc2].y;
                char[_loc2].charMove();
            } // end else if
            if (char[_loc2].charState == 3 || char[_loc2].charState == 5)
            {
                for (var _loc4 = 0; _loc4 < charCount; ++_loc4)
                {
                    if (char[_loc4].charState >= 7 && _loc4 != _loc2)
                    {
                        if (Math.abs(char[_loc2].x - char[_loc4].x) < char[_loc2].w + char[_loc4].w && char[_loc4].y > char[_loc2].y - char[_loc2].h && char[_loc4].y < char[_loc2].y + char[_loc4].h)
                        {
                            startDeath(_loc4);
                        } // end if
                    } // end if
                } // end of for
            } // end if
            if (char[_loc2].justChanged >= 1)
            {
                if (char[_loc2].standingOn >= 1)
                {
                    if (char[char[_loc2].standingOn].charState == 4)
                    {
                        char[_loc2].justChanged = 2;
                    } // end if
                } // end if
                if (char[_loc2].stoodOnBy.length >= 1)
                {
                    for (var _loc4 = 0; _loc4 < char[_loc2].stoodOnBy.length; ++_loc4)
                    {
                        char[char[_loc2].stoodOnBy[_loc4]].y = char[_loc2].y - char[_loc2].h;
                        char[char[_loc2].stoodOnBy[_loc4]].vy = char[_loc2].vy;
                    } // end of for
                }
                else if (!char[_loc2].carry && char[_loc2].submerged >= 2)
                {
                    char[_loc2].weight2 = char[_loc2].weight - 0.160000;
                } // end else if
                if (char[_loc2].charState >= 5 && !ifCarried(_loc2))
                {
                    if (char[_loc2].vy > 0 || char[_loc2].vy == 0 && char[_loc2].vx != 0)
                    {
                        landOnObject(_loc2);
                    } // end if
                    if (char[_loc2].vy < 0 && (char[_loc2].charState == 4 || char[_loc2].charState == 6) && !ifCarried(_loc2))
                    {
                        objectsLandOn(_loc2);
                    } // end if
                } // end if
            } // end if
            if (char[_loc2].charState >= 7 && char[_loc2].charState != 9 && !gotThisCoin)
            {
                var _loc7 = calcDist(_loc2);
                if (_loc7 < locations[4])
                {
                    locations[4] = _loc7;
                    locations[5] = _loc2;
                } // end if
            } // end if
        } // end of for
        var _loc11;
        if (!gotThisCoin)
        {
            _loc11 = 140 - locations[4] * 0.700000;
        } // end if
        if (gotCoin[currentLevel])
        {
            _loc11 = Math.max(_loc11, 30);
        } // end if
        levelActive["tileX" + locations[2] + "Y" + locations[3]]._alpha = _loc11;
        for (var _loc2 = 0; _loc2 < charCount; ++_loc2)
        {
            if (char[_loc2].vy != 0 || char[_loc2].vx != 0 || char[_loc2].x != char[_loc2].px || char[_loc2].py != char[_loc2].y)
            {
                char[_loc2].justChanged = 2;
            } // end if
            if (char[_loc2].charState == 2)
            {
                --recoverTimer;
                var _loc5 = (60 - recoverTimer) / 60;
                levelChar["char" + _loc2]._yscale = _loc5 * 100;
                levelChar["char" + _loc2]._x = inter(char[HPRC1].x, goal, _loc5);
                if (recoverTimer <= 0)
                {
                    recoverTimer = 0;
                    recover = false;
                    char[recover2].dire = 4;
                    char[recover2].charState = char[recover2].pcharState;
                    char[recover2].deathTimer = 30;
                    char[recover2].x = goal;
                    char[recover2].px = char[recover2].x;
                    char[recover2].py = char[recover2].y;
                    char[recover2].justChanged = 2;
                    checkDeath(_loc2);
                } // end if
            }
            else if (char[_loc2].justChanged >= 1 && char[_loc2].charState >= 5)
            {
                for (var _loc3 = Math.floor((char[_loc2].y - char[_loc2].h) / 30); _loc3 <= Math.floor(char[_loc2].y / 30); ++_loc3)
                {
                    for (var _loc9 = Math.floor((char[_loc2].x - char[_loc2].w) / 30); _loc9 <= Math.floor((char[_loc2].x + char[_loc2].w - 0.010000) / 30); ++_loc9)
                    {
                        if (blockProperties[thisLevel[_loc3][_loc9]][11] >= 1 && blockProperties[thisLevel[_loc3][_loc9]][11] <= 12)
                        {
                            if (Math.floor(char[_loc2].x / 30) == _loc9)
                            {
                                var _loc1 = (char[_loc2].x - Math.floor(char[_loc2].x / 30) * 30 - 15) * 5;
                                if (_loc1 < levelActive2["tileX" + _loc9 + "Y" + _loc3].lever._rotation && char[_loc2].vx < 0 || _loc1 > levelActive2["tileX" + _loc9 + "Y" + _loc3].lever._rotation && char[_loc2].vx > 0)
                                {
                                    if (_loc1 < 0 && levelActive2["tileX" + _loc9 + "Y" + _loc3].lever._rotation > 0 || _loc1 > 0 && levelActive2["tileX" + _loc9 + "Y" + _loc3].lever._rotation < 0)
                                    {
                                        leverSwitch((blockProperties[thisLevel[_loc3][_loc9]][11] - 1) % 6);
                                    } // end if
                                    levelActive2["tileX" + _loc9 + "Y" + _loc3].lever._rotation = _loc1;
                                } // end if
                            } // end if
                        } // end if
                    } // end of for
                } // end of for
                checkButton2(_loc2, false);
                if (ifCarried(_loc2))
                {
                    char[_loc2].vx = char[char[_loc2].carriedBy].vx;
                    char[_loc2].vy = char[char[_loc2].carriedBy].vy;
                    if (char[char[_loc2].carriedBy].x + xOff(_loc2) >= char[_loc2].x + 20)
                    {
                        char[_loc2].x = char[_loc2].x + 20;
                    }
                    else if (char[char[_loc2].carriedBy].x + xOff(_loc2) <= char[_loc2].x - 20)
                    {
                        char[_loc2].x = char[_loc2].x - 20;
                    }
                    else
                    {
                        char[_loc2].x = char[char[_loc2].carriedBy].x + xOff(_loc2);
                    } // end else if
                    if (char[char[_loc2].carriedBy].y - yOff(_loc2) >= char[_loc2].y + 20)
                    {
                        char[_loc2].y = char[_loc2].y + 20;
                    }
                    else if (char[char[_loc2].carriedBy].y - yOff(_loc2) <= char[_loc2].y - 20)
                    {
                        char[_loc2].y = char[_loc2].y - 20;
                    }
                    else
                    {
                        char[_loc2].y = char[char[_loc2].carriedBy].y - yOff(_loc2);
                    } // end else if
                    char[_loc2].dire = Math.ceil(char[char[_loc2].carriedBy].dire / 2) * 2;
                } // end if
                if (char[_loc2].standingOn >= 0)
                {
                    char[_loc2].y = char[char[_loc2].standingOn].y - char[char[_loc2].standingOn].h;
                    char[_loc2].vy = char[char[_loc2].standingOn].vy;
                } // end if
                stopX = 0;
                stopY = 0;
                toBounce = false;
                if (newTileHorizontal(_loc2, 1))
                {
                    if (horizontalType(_loc2, 1, 8) && char[_loc2].charState == 10)
                    {
                        startCutScene();
                    } // end if
                    if (horizontalProp(_loc2, 1, 7, char[_loc2].x, char[_loc2].y) && char[_loc2].charState >= 7)
                    {
                        startDeath(_loc2);
                    }
                    else if (char[_loc2].x > char[_loc2].px && horizontalProp(_loc2, 1, 3, char[_loc2].x, char[_loc2].y))
                    {
                        stopX = 1;
                    } // end if
                } // end else if
                if (newTileHorizontal(_loc2, -1))
                {
                    if (horizontalType(_loc2, -1, 8) && char[_loc2].charState == 10)
                    {
                        startCutScene();
                    } // end if
                    if (horizontalProp(_loc2, -1, 6, char[_loc2].x, char[_loc2].y) && char[_loc2].charState >= 7)
                    {
                        startDeath(_loc2);
                    }
                    else if (char[_loc2].x < char[_loc2].px && horizontalProp(_loc2, -1, 2, char[_loc2].x, char[_loc2].y))
                    {
                        stopX = -1;
                    } // end if
                } // end else if
                if (newTileDown(_loc2))
                {
                    if (verticalType(_loc2, 1, 8, false) && char[_loc2].charState == 10)
                    {
                        startCutScene();
                    } // end if
                    if (verticalType(_loc2, 1, 13, true))
                    {
                        toBounce = true;
                    }
                    else if (verticalProp(_loc2, 1, 5, char[_loc2].px, char[_loc2].y) && char[_loc2].charState >= 7)
                    {
                        startDeath(_loc2);
                    }
                    else if (char[_loc2].y > char[_loc2].py && verticalProp(_loc2, 1, 1, char[_loc2].px, char[_loc2].y))
                    {
                        stopY = 1;
                    } // end else if
                } // end else if
                if (newTileUp(_loc2))
                {
                    if (verticalType(_loc2, -1, 8, false) && char[_loc2].charState == 10)
                    {
                        startCutScene();
                    } // end if
                    if (verticalProp(_loc2, -1, 4, char[_loc2].x, char[_loc2].y) && char[_loc2].charState >= 7)
                    {
                        startDeath(_loc2);
                    }
                    else if (char[_loc2].y < char[_loc2].py && verticalProp(_loc2, -1, 0, char[_loc2].px, char[_loc2].y))
                    {
                        stopY = -1;
                    } // end if
                } // end else if
                if (stopX != 0 && stopY != 0)
                {
                    if (stopY == 1)
                    {
                        _loc3 = Math.floor(char[_loc2].y / 30) * 30;
                    } // end if
                    if (stopY == -1)
                    {
                        _loc3 = Math.ceil((char[_loc2].y - char[_loc2].h) / 30) * 30 + char[_loc2].h;
                    } // end if
                    if (!horizontalProp(_loc2, stopX, stopX / 2 + 2.500000, char[_loc2].x, _loc3))
                    {
                        stopX = 0;
                    }
                    else
                    {
                        if (stopX == 1)
                        {
                            _loc9 = Math.floor((char[_loc2].x + char[_loc2].w) / 30) * 30 - char[_loc2].w;
                        } // end if
                        if (stopX == -1)
                        {
                            _loc9 = Math.ceil((char[_loc2].x - char[_loc2].w) / 30) * 30 + char[_loc2].w;
                        } // end if
                        if (!verticalProp(_loc2, stopY, stopY / 2 + 0.500000, _loc9, char[_loc2].y))
                        {
                            stopY = 0;
                        } // end if
                    } // end if
                } // end else if
                if (stopX != 0)
                {
                    char[_loc2].fricGoal = 0;
                    if (char[_loc2].submerged >= 2)
                    {
                        _loc4 = _loc2;
                        if (ifCarried(_loc2))
                        {
                            _loc4 = char[_loc2].carriedBy;
                        } // end if
                        if (char[_loc4].dire % 2 == 1)
                        {
                            char[_loc4].swimUp(0.140000 / char[_loc4].weight2);
                            if (char[_loc4].standingOn >= 0)
                            {
                                fallOff(_loc2);
                            } // end if
                            char[_loc4].onob = false;
                        } // end if
                    } // end if
                    if (char[_loc2].id == 5)
                    {
                        startDeath(_loc2);
                    } // end if
                    if (stopX == 1)
                    {
                        _loc9 = Math.floor((char[_loc2].x + char[_loc2].w) / 30) * 30 - char[_loc2].w;
                    }
                    else if (stopX == -1)
                    {
                        _loc9 = Math.ceil((char[_loc2].x - char[_loc2].w) / 30) * 30 + char[_loc2].w;
                    } // end else if
                    char[_loc2].x = _loc9;
                    char[_loc2].vx = 0;
                    stopCarrierX(_loc2, _loc9);
                } // end if
                if (stopY != 0)
                {
                    if (stopY == 1)
                    {
                        _loc3 = Math.floor(char[_loc2].y / 30) * 30;
                        if (!ifCarried(_loc2))
                        {
                            cornerHangTimer = 0;
                        } // end if
                        fallOff(_loc2);
                        land(_loc2, _loc3, 0);
                        land2(_loc2, _loc3);
                        checkButton(_loc2);
                    }
                    else if (stopY == -1)
                    {
                        if (char[_loc2].id == 5)
                        {
                            startDeath(_loc2);
                        } // end if
                        if (char[_loc2].id == 3 && char[_loc2].temp > 50)
                        {
                            char[_loc2].temp = 0;
                        } // end if
                        _loc3 = Math.ceil((char[_loc2].y - char[_loc2].h) / 30) * 30 + char[_loc2].h;
                        char[_loc2].y = _loc3;
                        char[_loc2].vy = 0;
                        bumpHead(_loc2);
                        if (ifCarried(_loc2))
                        {
                            bumpHead(char[_loc2].carriedBy);
                        } // end if
                    } // end else if
                    stopCarrierY(_loc2, _loc3, stopY == 1);
                } // end if
                if (newTileHorizontal(_loc2, 1) || newTileHorizontal(_loc2, -1))
                {
                    if (verticalType(_loc2, 1, 13, true))
                    {
                        toBounce = true;
                    } // end if
                    if (horizontalProp(_loc2, 1, 14, char[_loc2].x, char[_loc2].y) || horizontalProp(_loc2, -1, 14, char[_loc2].x, char[_loc2].y))
                    {
                        submerge(_loc2);
                    } // end if
                    if (horizontalType(_loc2, 1, 15) || horizontalType(_loc2, -1, 15))
                    {
                        char[_loc2].heated = 1;
                    } // end if
                    checkButton(_loc2);
                } // end if
                if (newTileUp(_loc2))
                {
                    if (verticalProp(_loc2, -1, 14, char[_loc2].x, char[_loc2].y))
                    {
                        submerge(_loc2);
                    } // end if
                    if (verticalType(_loc2, -1, 15, false))
                    {
                        char[_loc2].heated = 1;
                    } // end if
                } // end if
                if (newTileDown(_loc2))
                {
                    if (verticalProp(_loc2, 1, 14, char[_loc2].x, char[_loc2].y))
                    {
                        submerge(_loc2);
                    } // end if
                    if (verticalType(_loc2, 1, 15, false))
                    {
                        char[_loc2].heated = 1;
                    } // end if
                } // end if
                if (char[_loc2].submerged >= 2 && char[_loc2].standingOn >= 0 && char[_loc2].weight2 < 0)
                {
                    fallOff(_loc2);
                } // end if
                if (char[_loc2].submerged >= 2)
                {
                    unsubmerge(_loc2);
                } // end if
                if (char[_loc2].heated >= 1)
                {
                    heat(_loc2);
                }
                else if (char[_loc2].id != 3 || char[_loc2].temp <= 50)
                {
                    if (char[_loc2].temp >= 0)
                    {
                        char[_loc2].temp = char[_loc2].temp - char[_loc2].heatSpeed;
                        char[_loc2].justChanged = 2;
                    }
                    else
                    {
                        char[_loc2].temp = 0;
                    } // end else if
                } // end else if
                if (char[_loc2].heated == 2)
                {
                    char[_loc2].heated = 0;
                } // end if
                if (char[_loc2].standingOn >= 0)
                {
                    _loc4 = char[_loc2].standingOn;
                    if (Math.abs(char[_loc2].x - char[_loc4].x) >= char[_loc2].w + char[_loc4].w || ifCarried(_loc4))
                    {
                        fallOff(_loc2);
                    } // end if
                }
                else if (char[_loc2].onob)
                {
                    if (!ifCarried(_loc2) && char[_loc2].standingOn == -1)
                    {
                        char[_loc2].y = Math.round(char[_loc2].y / 30) * 30;
                    } // end if
                    if (!verticalProp(_loc2, 1, 1, char[_loc2].x, char[_loc2].y))
                    {
                        char[_loc2].onob = false;
                        aboveFallOff(_loc2);
                        if (ifCarried(_loc2))
                        {
                            cornerHangTimer = 0;
                        } // end if
                    } // end if
                    if (char[_loc2].charState >= 7 && verticalProp(_loc2, 1, 5, char[_loc2].x, char[_loc2].y))
                    {
                        startDeath(_loc2);
                    } // end if
                } // end else if
            } // end else if
            if (char[_loc2].charState >= 5)
            {
                char[_loc2].px = char[_loc2].x;
                char[_loc2].py = char[_loc2].y;
                if (char[_loc2].justChanged >= 1 && char[_loc2].charState >= 5)
                {
                    if (toBounce)
                    {
                        bounce(_loc2);
                    } // end if
                    getCoin(_loc2);
                } // end if
                if (char[_loc2].deathTimer < 30)
                {
                    if (char[_loc2].id == 5 && char[_loc2].deathTimer >= 7)
                    {
                        char[_loc2].deathTimer = 6;
                        levelChar["char" + _loc2].leg1._visible = false;
                        levelChar["char" + _loc2].leg2._visible = false;
                    } // end if
                    --char[_loc2].deathTimer;
                    blinkDeath(_loc2);
                    if (char[_loc2].deathTimer <= 0)
                    {
                        endDeath(_loc2);
                    } // end if
                }
                else if (char[_loc2].charState >= 7 && (char[_loc2].justChanged >= 1 || levelTimer == 0))
                {
                    setBody(_loc2);
                } // end else if
                if (_loc2 == HPRC2)
                {
                    if (!recover)
                    {
                        levelChar["char" + _loc2].charBody.textie.text = "";
                    }
                    else if (recoverTimer == 0)
                    {
                        levelChar["char" + _loc2].charBody.textie.text = "enter name";
                    }
                    else if (recoverTimer > 40)
                    {
                        levelChar["char" + _loc2].charBody.textie.text = names[char[recover2].id];
                    }
                    else if (recoverTimer > 10)
                    {
                        levelChar["char" + _loc2].charBody.textie.text = "Keep going";
                    }
                    else
                    {
                        levelChar["char" + _loc2].charBody.textie.text = "Done";
                    } // end else if
                    levelChar["char" + _loc2].charBody.crank._rotation = recoverTimer * 12;
                    if (!recover && HPRCBubble.charImage._currentframe <= 2)
                    {
                        if (near(control, _loc2) && numberOfDead() >= 1 && char[control].id != 2)
                        {
                            HPRCBubble.charImage.gotoAndStop(2);
                        }
                        else
                        {
                            HPRCBubble.charImage.gotoAndStop(1);
                        } // end if
                    } // end if
                } // end else if
                if (char[_loc2].y > levelHeight * 30 + 160 && char[_loc2].charState >= 7)
                {
                    startDeath(_loc2);
                } // end if
                if (char[_loc2].charState == 10 && char[_loc2].justChanged >= 1)
                {
                    if (Math.abs(char[_loc2].x - locations[0] * 30) <= 30 && Math.abs(char[_loc2].y - (locations[1] * 30 + 10)) <= 50)
                    {
                        if (!char[_loc2].atEnd)
                        {
                            ++charsAtEnd;
                            levelActive["tileX" + locations[0] + "Y" + locations[1]].light["light" + charsAtEnd].gotoAndPlay(2);
                            if (charsAtEnd >= charCount2)
                            {
                                wipeTimer = 1;
                                if (playMode == 0)
                                {
                                    transitionType = 1;
                                }
                                else
                                {
                                    transitionType = 2;
                                } // end if
                            } // end if
                        } // end else if
                        char[_loc2].atEnd = true;
                    }
                    else
                    {
                        if (char[_loc2].atEnd)
                        {
                            levelActive["tileX" + locations[0] + "Y" + locations[1]].light["light" + charsAtEnd].gotoAndPlay(16);
                            --charsAtEnd;
                        } // end if
                        char[_loc2].atEnd = false;
                    } // end if
                } // end else if
                if (_loc2 == control)
                {
                    setCamera();
                } // end if
            } // end if
            if (char[_loc2].charState >= 3)
            {
                if (qTimer > 0 || char[_loc2].justChanged >= 1)
                {
                    var _loc6 = 0;
                    if (_loc2 == control && qTimer > 0)
                    {
                        _loc6 = 9 - Math.pow(qTimer - 4, 2);
                    } // end if
                    levelChar["char" + _loc2]._x = char[_loc2].x;
                    levelChar["char" + _loc2]._y = char[_loc2].y - _loc6;
                    if (_loc2 == HPRC2)
                    {
                        HPRCBubble.charImage._x = char[_loc2].x;
                        HPRCBubble.charImage._y = char[_loc2].y - 78;
                    } // end if
                    if (char[_loc2].deathTimer >= 30)
                    {
                        setTint(_loc2);
                    } // end if
                } // end if
                --char[_loc2].justChanged;
            } // end if
        } // end of for
        --qTimer;
        _loc9 = -cameraX;
        _loc3 = -cameraY;
        if (wipeTimer < 60)
        {
            _loc9 = _loc9 + (Math.random() - 0.500000) * (30 - Math.abs(wipeTimer - 30));
            _loc3 = _loc3 + (Math.random() - 0.500000) * (30 - Math.abs(wipeTimer - 30));
        } // end if
        if (char[control].temp > 0 && char[control].temp <= 50)
        {
            _loc9 = _loc9 + (Math.random() - 0.500000) * char[control].temp * 0.200000;
            _loc3 = _loc3 + (Math.random() - 0.500000) * char[control].temp * 0.200000;
        } // end if
        setMovieClipCoordinates(_loc9, _loc3);
        ++levelTimer;
    } // end if
    if (menuScreen == 5)
    {
        _loc9 = Math.floor((_xmouse - (330 - scale * levelWidth / 2)) / scale);
        _loc3 = Math.floor((_ymouse - (240 - scale * levelHeight / 2)) / scale);
        if (mouseIsDown)
        {
            if (selectedTab == 3)
            {
                if (tool <= 1 && mouseOnGrid())
                {
                    if (tool == 1)
                    {
                        _loc2 = 0;
                    }
                    else
                    {
                        _loc2 = selectedTile;
                    } // end else if
                    if (_loc2 >= 0 && _loc2 < tileCount)
                    {
                        myLevel[1][_loc3][_loc9] = _loc2;
                        levelCreator.tiles["tileX" + _loc9 + "Y" + _loc3].gotoAndStop(_loc2 + 1);
                        if (_loc2 == 6 && (_loc9 != LCEndGateX || _loc3 != LCEndGateY))
                        {
                            myLevel[1][LCEndGateY][LCEndGateX] = 0;
                            levelCreator.tiles["tileX" + LCEndGateX + "Y" + LCEndGateY].gotoAndStop(1);
                            LCEndGateX = _loc9;
                            LCEndGateY = _loc3;
                            setEndGateLights();
                        } // end if
                    } // end if
                } // end if
            } // end if
            if ((tool == 2 || tool == 5) && LCRect[0] != -1)
            {
                if (_loc9 != LCRect[2] || _loc3 != LCRect[3])
                {
                    LCRect[2] = Math.min(Math.max(_loc9, 0), levelWidth - 1);
                    LCRect[3] = Math.min(Math.max(_loc3, 0), levelHeight - 1);
                    drawLCRect(Math.min(LCRect[0], LCRect[2]), Math.min(LCRect[1], LCRect[3]), Math.max(LCRect[0], LCRect[2]), Math.max(LCRect[1], LCRect[3]));
                } // end if
            } // end if
        } // end if
        if (mouseOnGrid())
        {
            if (tool == 6)
            {
                levelCreator.rectSelect.clear();
                var _loc13;
                var _loc12;
                if (closeToEdgeY())
                {
                    levelCreator.rectSelect.lineStyle(2 * scale / 9, 32768, 100);
                    _loc13 = Math.round((_ymouse - (240 - scale * levelHeight / 2)) / scale);
                    _loc12 = 0;
                }
                else
                {
                    levelCreator.rectSelect.lineStyle(2 * scale / 9, 8388608, 100);
                    _loc13 = Math.floor((_ymouse - (240 - scale * levelHeight / 2)) / scale);
                    _loc12 = 0.500000;
                } // end else if
                levelCreator.rectSelect.moveTo(330 - scale * levelWidth / 2, 240 - scale * levelHeight / 2 + scale * (_loc13 + _loc12));
                levelCreator.rectSelect.lineTo(330 + scale * levelWidth / 2, 240 - scale * levelHeight / 2 + scale * (_loc13 + _loc12));
            }
            else if (tool == 7)
            {
                levelCreator.rectSelect.clear();
                var _loc14;
                var _loc10;
                if (closeToEdgeX())
                {
                    levelCreator.rectSelect.lineStyle(2 * scale / 9, 32768, 100);
                    _loc14 = Math.round((_xmouse - (330 - scale * levelWidth / 2)) / scale);
                    _loc10 = 0;
                }
                else
                {
                    levelCreator.rectSelect.lineStyle(2 * scale / 9, 8388608, 100);
                    _loc14 = Math.floor((_xmouse - (330 - scale * levelWidth / 2)) / scale);
                    _loc10 = 0.500000;
                } // end else if
                levelCreator.rectSelect.moveTo(330 - scale * levelWidth / 2 + scale * (_loc14 + _loc10), 240 - scale * levelHeight / 2);
                levelCreator.rectSelect.lineTo(330 - scale * levelWidth / 2 + scale * (_loc14 + _loc10), 240 + scale * levelHeight / 2);
            } // end else if
        }
        else if (tool == 6 || tool == 7)
        {
            levelCreator.rectSelect.clear();
        } // end else if
        for (var _loc2 = 0; _loc2 < 6; ++_loc2)
        {
            _loc3 = _loc2 * 40;
            if (_loc2 > selectedTab)
            {
                _loc3 = _loc3 + 300;
            } // end if
            if (Math.abs(levelCreator.sideBar["tab" + (_loc2 + 1)]._y - _loc3) < 0.500000)
            {
                levelCreator.sideBar["tab" + (_loc2 + 1)]._y = _loc3;
                continue;
            } // end if
            levelCreator.sideBar["tab" + (_loc2 + 1)]._y = levelCreator.sideBar["tab" + (_loc2 + 1)]._y + (_loc3 - levelCreator.sideBar["tab" + (_loc2 + 1)]._y) * 0.200000;
        } // end of for
    } // end if
    if (levelTimer <= 30 || menuScreen != 4)
    {
        if (wipeTimer >= 30 && wipeTimer <= 60)
        {
            white._alpha = 220 - wipeTimer * 4;
        } // end if
    }
    else
    {
        white._alpha = 0;
    } // end else if
    if (wipeTimer == 29 && menuScreen == 4 && (charsAtEnd >= charCount2 || transitionType == 0))
    {
        white._alpha = 100;
    } // end if
    if (wipeTimer >= 60)
    {
        wipeTimer = 0;
    } // end if
    if (wipeTimer >= 1)
    {
        ++wipeTimer;
    } // end if
};
_root.onMouseDown = function ()
{
    mouseIsDown = true;
    if (menuScreen == 5)
    {
        if (_xmouse > 660)
        {
            for (var _loc8 = 0; _loc8 < 6; ++_loc8)
            {
                var _loc9 = _loc8 * 40;
                if (_loc8 > selectedTab)
                {
                    _loc9 = _loc9 + 300;
                } // end if
                if (_ymouse >= _loc9 && _ymouse < _loc9 + 40)
                {
                    setSelectedTab(_loc8);
                    if (_loc8 == 3 && (selectedTile < 0 || selectedTile > tileCount))
                    {
                        setTool(0);
                        setSelectedTile(1);
                    } // end if
                    break;
                } // end if
            } // end of for
            if (selectedTab == 3)
            {
                var _loc10 = Math.floor((_xmouse - 660) / 60);
                _loc9 = Math.floor((_ymouse - 160) / 60);
                _loc8 = _loc10 + _loc9 * 5;
                if (_loc8 >= 0 && _loc8 < tileCount && (tool != 3 && tool != 2 || !blockProperties[_loc8][9]))
                {
                    setSelectedTile(_loc8);
                    if (_loc8 >= 1 && tool == 1)
                    {
                        setTool(0);
                    } // end if
                } // end if
            }
            else
            {
                setSelectedTile(1000);
            } // end else if
            clearRectSelect();
        }
        else if (Math.abs(_ymouse - 510) <= 20 && Math.abs(_xmouse - 330) <= 300)
        {
            _loc8 = Math.floor((_xmouse - 30) / 50);
            if (_loc8 != 8)
            {
                if (_loc8 >= 9)
                {
                    --_loc8;
                } // end if
                if (_loc8 == 9)
                {
                    undo();
                }
                else if (_loc8 == 10)
                {
                    setUndo();
                    clearMyLevel(1);
                    updateLCtiles();
                }
                else
                {
                    setTool(_loc8);
                    if (tool <= 3)
                    {
                        setSelectedTab(3);
                        if ((tool == 3 || tool == 2) && blockProperties[selectedTile][9])
                        {
                            setSelectedTile(1);
                        } // end if
                    } // end if
                } // end else if
            } // end else if
        }
        else
        {
            if (tool != 4 && tool != 5)
            {
                setUndo();
            } // end if
            _loc10 = Math.floor((_xmouse - (330 - scale * levelWidth / 2)) / scale);
            _loc9 = Math.floor((_ymouse - (240 - scale * levelHeight / 2)) / scale);
            if (mouseOnScreen())
            {
                if (tool == 2 || tool == 5)
                {
                    LCRect[0] = LCRect[2] = Math.min(Math.max(_loc10, 0), levelWidth - 1);
                    LCRect[1] = LCRect[3] = Math.min(Math.max(_loc9, 0), levelHeight - 1);
                } // end if
            } // end if
            if (mouseOnGrid())
            {
                if (tool == 3)
                {
                    var _loc11 = myLevel[1][_loc9][_loc10];
                    fillTile(_loc10, _loc9, selectedTile, _loc11);
                }
                else if (tool == 4)
                {
                    setSelectedTab(3);
                    setSelectedTile(myLevel[1][_loc9][_loc10]);
                }
                else if (tool == 6)
                {
                    var _loc5 = 0;
                    if (closeToEdgeY() || levelHeight >= 2)
                    {
                        if (closeToEdgeY())
                        {
                            _loc5 = 1;
                        }
                        else
                        {
                            _loc5 = -1;
                        } // end else if
                        clearLCGrid();
                        var _loc7 = Math.round((_ymouse - (240 - scale * levelHeight / 2)) / scale);
                        levelHeight = levelHeight + _loc5;
                        myLevel[1] = new Array(levelHeight);
                        var _loc4 = 0;
                        for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
                        {
                            if (_loc2 < _loc7)
                            {
                                _loc4 = _loc2;
                            }
                            else
                            {
                                _loc4 = Math.max(_loc2 - _loc5, 0);
                            } // end else if
                            myLevel[1][_loc2] = new Array(levelWidth);
                            for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
                            {
                                myLevel[1][_loc2][_loc1] = myLevel[0][_loc4][_loc1];
                            } // end of for
                        } // end of for
                        drawLCGrid();
                    } // end if
                }
                else if (tool == 7)
                {
                    var _loc6 = (_xmouse - (330 - scale * levelWidth / 2)) / scale % 1;
                    _loc5 = 0;
                    if (closeToEdgeX() || levelWidth >= 2)
                    {
                        if (closeToEdgeX())
                        {
                            _loc5 = 1;
                        }
                        else
                        {
                            _loc5 = -1;
                        } // end else if
                        clearLCGrid();
                        _loc6 = Math.round((_xmouse - (330 - scale * levelWidth / 2)) / scale);
                        levelWidth = levelWidth + _loc5;
                        myLevel[1] = new Array(levelHeight);
                        var _loc3 = 0;
                        for (var _loc2 = 0; _loc2 < levelHeight; ++_loc2)
                        {
                            myLevel[1][_loc2] = new Array(levelWidth);
                            for (var _loc1 = 0; _loc1 < levelWidth; ++_loc1)
                            {
                                if (_loc1 < _loc6)
                                {
                                    _loc3 = _loc1;
                                }
                                else
                                {
                                    _loc3 = Math.max(_loc1 - _loc5, 0);
                                } // end else if
                                myLevel[1][_loc2][_loc1] = myLevel[0][_loc2][_loc3];
                            } // end of for
                        } // end of for
                        drawLCGrid();
                    } // end else if
                } // end else if
            } // end else if
        } // end else if
    } // end else if
};
_root.onMouseUp = function ()
{
    if (tool == 2)
    {
        for (y = Math.min(LCRect[1], LCRect[3]); y <= Math.max(LCRect[1], LCRect[3]); y++)
        {
            for (x = Math.min(LCRect[0], LCRect[2]); x <= Math.max(LCRect[0], LCRect[2]); x++)
            {
                myLevel[1][y][x] = selectedTile;
                levelCreator.tiles["tileX" + x + "Y" + y].gotoAndStop(selectedTile + 1);
            } // end of for
        } // end of for
        clearRectSelect();
    } // end if
    mouseIsDown = false;
};
