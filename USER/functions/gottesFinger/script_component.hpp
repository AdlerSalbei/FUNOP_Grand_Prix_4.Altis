#define PREFIX grad_grandPrix
#define COMPONENT gottesFinger
#define CUSTOM_FOLDER USER\functions\gottesFinger

#include "\x\cba\addons\main\script_macros_mission.hpp"

#define FUNC_CUSTOM(var1) FUNCMAIN(DOUBLES(COMPONENT,var1))
#define QFUNC_CUSTOM(var1) QUOTE(FUNC_CUSTOM(var1))