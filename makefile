BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj

STM32CubeL4_CMSIS := submodules/STM32CubeL4/Drivers/CMSIS
STM32CubeL4_CMSIS_DSP := submodules/STM32CubeL4/Drivers/CMSIS/DSP
FreeRTOS_Kernel := submodules/FreeRTOS/FreeRTOS/Source
FreeRTOS_CLI := submodules/FreeRTOS/FreeRTOS-Plus/Source/FreeRTOS-Plus-CLI

# All Include Directories
INC_DIR := inc
SUB_INCS := $(STM32CubeL4_CMSIS)/Device/ST/STM32L4xx/Include \
			$(STM32CubeL4_CMSIS)/Include \
			$(STM32CubeL4_CMSIS_DSP)/Include \
			$(FreeRTOS_Kernel)/include \
			$(FreeRTOS_Kernel)/portable/GCC/ARM_CM4F \
			$(FreeRTOS_CLI)/

INCS := $(addprefix -I, $(SUB_INCS) $(INC_DIR))

# All Source Files
SRC_DIR := src

CMSIS_DSP_SRCS := $(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_rfft_init_q15.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_rfft_q15.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_cfft_q15.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_cfft_radix4_q15.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_bitreversal.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/TransformFunctions/arm_bitreversal2.c \

SINGLE_SRCS := 	$(STM32CubeL4_CMSIS)/Device/ST/STM32L4xx/Source/Templates/system_stm32l4xx.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/BasicMathFunctions/BasicMathFunctions.c \
				$(STM32CubeL4_CMSIS_DSP)/Source/CommonTables/CommonTables.c \
				$(FreeRTOS_Kernel)/portable/GCC/ARM_CM4F/port.c \
				$(FreeRTOS_Kernel)/portable/MemMang/heap_4.c \
				$(FreeRTOS_CLI)/FreeRTOS_CLI.c \

SRCS := $(SINGLE_SRCS) \
		$(CMSIS_DSP_SRCS) \
		$(wildcard $(SRC_DIR)/*.c) \
		$(wildcard $(FreeRTOS_Kernel)/*.c)

# All Assembly Files
SUB_ASMS := $(STM32CubeL4_CMSIS)/Device/ST/STM32L4xx/Source/Templates/gcc/startup_stm32l432xx.s \

ASMS := $(SUB_ASMS) \
		$(wildcard $(SRC_DIR)/*.s)

COBJS := $(patsubst %.c, $(OBJ_DIR)/%.o, $(SRCS))
AOBJS := $(patsubst %.s, $(OBJ_DIR)/%.o, $(ASMS))

ARCH_DEFS := -mthumb -mcpu=cortex-m4 -march=armv7e-m
FPU_DEFS := -mfpu=fpv4-sp-d16 -mfloat-abi=hard
COMPILER_DEFS := -g -Os -fdata-sections -ffunction-sections -specs=nano.specs -specs=nosys.specs
CMSIS_DSP_DEFS := -DARM_DSP_CONFIG_TABLES -DARM_TABLE_TWIDDLECOEF_Q15_16 -DARM_TABLE_BITREVIDX_FXT_16 -DARM_FFT_ALLOW_TABLES -DARM_TABLE_REALCOEF_Q15
DDEFS := -DSTM32L432xx
CDEFS := 	$(ARCH_DEFS) \
			$(FPU_DEFS) \
			$(COMPILER_DEFS) \
			$(CMSIS_DSP_DEFS) \
			$(DDEFS) \
			$(INCS) \

#ADEFS := $(INCS) \


TARGET := firmware
all: $(BUILD_DIR)/$(TARGET).elf

$(COBJS): $(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "gcc -c $(notdir $^) -o $(notdir $@)"
	@arm-none-eabi-gcc $(CDEFS) -c $^ -o $@ 


$(AOBJS): $(OBJ_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	@echo "gcc -c $(notdir $^) -o $(notdir $@)"
	@arm-none-eabi-gcc $(CDEFS) -c $^ -o $@

$(BUILD_DIR)/$(TARGET).elf: $(COBJS) $(AOBJS)
	arm-none-eabi-gcc $(CDEFS) -T STM32L432KC.ld $^ -Wl,--gc-sections -Wl,-Map=$(BUILD_DIR)/$(TARGET).map -o $@
	arm-none-eabi-objdump -S -d $@ > $(BUILD_DIR)/$(TARGET).asm
	arm-none-eabi-objdump -h $@ > $(BUILD_DIR)/$(TARGET).lst
	arm-none-eabi-size $@



clean:
	rm -rf $(BUILD_DIR)


