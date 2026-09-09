cmake_minimum_required(VERSION 3.8)
project(implot CXX)
option(BUILD_EXAMPLE "Build the example executable" OFF)

set(IMGUI_DIR "${CMAKE_BINARY_DIR}/imgui")

set(IMGUI_SOURCES
    ${IMGUI_DIR}/imgui.cpp
    ${IMGUI_DIR}/imgui_draw.cpp
    ${IMGUI_DIR}/imgui_widgets.cpp
    ${IMGUI_DIR}/imgui_tables.cpp
)

set(IMGUI_HEADERS
	${IMGUI_DIR}
)

set(CMAKE_DEBUG_POSTFIX d)

add_library(${PROJECT_NAME} "")
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
target_include_directories(
	${PROJECT_NAME}
	PUBLIC
	   	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		$<INSTALL_INTERFACE:include>
	PRIVATE
		${IMGUI_HEADERS}
)

target_link_libraries(${PROJECT_NAME}
	PUBLIC ${CMAKE_DL_LIBS}
)

# Build the 'example' executable and name it 'implot-example' if BUILD_EXAMPLE
# env var is truthy

if(BUILD_EXAMPLE)
	find_package(OpenGL REQUIRED)

	list(APPEND IMGUI_SOURCES
		${IMGUI_DIR}/imgui_demo.cpp
		${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
		${IMGUI_DIR}/backends/imgui_impl_opengl3.cpp
	)
	list(APPEND IMGUI_HEADERS ${IMGUI_DIR}/backends)

	target_link_libraries(${PROJECT_NAME}
		PUBLIC glfw OpenGL::GL)

	add_executable(implot-example
		${CMAKE_CURRENT_SOURCE_DIR}/example/main.cpp)

	target_include_directories(implot-example
		PRIVATE ${IMGUI_HEADERS})

	target_link_libraries(implot-example
		PRIVATE ${PROJECT_NAME})

	install(TARGETS implot-example)
endif()

target_sources(
	${PROJECT_NAME}
	PRIVATE
		${IMGUI_SOURCES}
		${CMAKE_CURRENT_SOURCE_DIR}/implot.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/implot_items.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/implot_demo.cpp
)

install(
	TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}_target
)

install(FILES
	${CMAKE_CURRENT_SOURCE_DIR}/implot.h
	${CMAKE_CURRENT_SOURCE_DIR}/implot_internal.h
	DESTINATION include
)

install(
	EXPORT ${PROJECT_NAME}_target
	NAMESPACE ${PROJECT_NAME}::
	FILE ${PROJECT_NAME}-config.cmake
	DESTINATION share/${PROJECT_NAME}
)
