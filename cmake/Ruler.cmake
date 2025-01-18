include(cmake/Core.cmake)
set(ae2f_RulerDir ${CMAKE_CURRENT_SOURCE_DIR} CACHE STRING "Ruler directory")
message(${ae2f_RulerDir})

function(ae2f_RulerMeasureFromSource prm_SourcePath prm_OutPath prm_DefinitionName prm_flags)
    execute_process(
        COMMAND
        ${CMAKE_CXX_COMPILER} ${prm_SourcePath} -o 
        ${ae2f_RulerDir}/workaround/a.out
        ${prm_flags}
    )

    execute_process(
        COMMAND ${ae2f_RulerDir}/workaround/a.out
        RESULTS_VARIABLE res
    )

    configure_file(${ae2f_RulerDir}/cmake/Ruler.h.in ${prm_OutPath})
endfunction()

function(ae2f_RulerMeasure prm_type prm_out prm_flags)
    configure_file(${ae2f_RulerDir}/cmake/Ruler.c.in ${ae2f_RulerDir}/workaround/a.c)
    file(WRITE ${ae2f_RulerDir}/workaround/a.h "")
    foreach(header ${ARGN})
        file(APPEND ${ae2f_RulerDir}/workaround/a.h "#include <${header}>\n")
    endforeach()

    ae2f_RulerMeasureFromSource(
        ${ae2f_RulerDir}/workaround/a.c
        ${prm_out}
        ${prm_type}_SIZE
        ${prm_flags}
    )
endfunction()