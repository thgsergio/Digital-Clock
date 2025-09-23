# ⏰ Digital Clock em SystemVerilog

Projeto de relógio digital desenvolvido em **SystemVerilog** para a disciplina de **Circuitos Lógicos II**.  
Implementado e testado no **Quartus II** com suporte para FPGA, exibindo **horas, minutos e segundos** em tempo real nos displays de 7 segmentos.

## 📌 Estrutura
- `enable_1hz.sv` → Divisor de frequência (gera pulso de 1 Hz a partir do clock da FPGA).  
- `maq_s.sv` → Contador de segundos (0–59).  
- `maq_m.sv` → Contador de minutos (0–59).  
- `maq_h.sv` → Contador de horas (0–23).  
- `display_7.sv` → Decodificador para display de 7 segmentos.  
- `topo.sv` → Módulo principal que integra todos os anteriores.

## 🚀 Funcionalidades
- Contagem precisa de horas, minutos e segundos.  
- Reset síncrono para reiniciar o relógio.  
- Exibição em **6 displays de 7 segmentos** (HH:MM:SS).  

## 🔧 Ferramentas
- Linguagem: **SystemVerilog**  
- Software: **Quartus II**  
- Hardware alvo: FPGA (ex.: DE1-SoC, Cyclone V)  

---

📖 Projeto acadêmico desenvolvido por:  
Gabriel Lorenzo Xavier, Iago Vitor Lopes das Chagas, João Pedro Pereira Maranhão,  
Luis Eduardo Pereira Nunes da Costa, Thiago Sergio Lima de Oliveira. 
