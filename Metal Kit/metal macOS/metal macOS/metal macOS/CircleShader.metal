//
//  CircleShader.metal
//  metal macOS
//
//  Created by Hudihka on 07/01/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;


struct VertexOut{
	/*
	 [[position]] атрибут сообщает металлу, что нужно использовать positionполе структуры в качестве нормализованного положения экрана. Возможно, вы уже заметили, что это 4-х мерное поле вместо 2D, которое мы передаем для позиции. Третья / четвертая координаты представляют собой глубину и однородное пространство - нам не о чем беспокоиться
	 
	 
	 Если вы не включите атрибут [[position]] в структуру, вы получите ошибку компиляции, сообщающую, что VertexOut является недопустимым типом возвращаемого значения.
	 */
    vector_float4 position [[position]];
    vector_float4 color;
};

//вершинная функция
//constant Атрибут указывает металл хранить данные вершин в пространстве памяти только для чтения.
//[[buffer(0)]]указывает , что мы хотим , чтобы первые (и только наши) буферные данные, передаваемые в этот параметр

//vid означает «идентификатор вектора». Это однозначно определяет, в какой вершине мы сейчас находимся; он будет использоваться как индекс для нашего vertexArray

vertex VertexOut vertexShader(const constant vector_float2 *vertexArray [[buffer(0)]],
							  unsigned int vid [[vertex_id]]){
	
    vector_float2 currentVertex = vertexArray[vid]; //// выбираем текущую вершину, в которой мы используем vid для индексации в данные нашего буфера, который содержит все наши точки вершин, которые мы передали
    VertexOut output;
    
    output.position = vector_float4(currentVertex.x, currentVertex.y, 0, 1); // заполняем выходную позицию значениями x и y наших входных данных вершины
    output.color = vector_float4(1,1,1,1); //set the color
    
    return output;
    
}

//функция фрагмента
//VertexOut interpolated [[stage_in]]
//Атрибут [[stage_in]] указывает металл , что переменная должна быть подается в интерполируемой результате растеризации.

fragment vector_float4 fragmentShader(VertexOut interpolated [[stage_in]]){
    return interpolated.color;
}
