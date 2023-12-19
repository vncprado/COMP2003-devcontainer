MEMORY
{
  RAM (xrw)  : ORIGIN = 0x0000, LENGTH = 256K
}

SECTIONS
{
  .text :
  {
      _stext = .;
    . = ALIGN(4);
    *(.text*) 
      _etext = .;
  } >RAM

  /* Read only initialized data */
  .rodata : 
  {
    . = ALIGN(8);
    _srodata = .;
    *(.rodata*)
    . = ALIGN(8);
    _erodata = .;
  } >RAM

  /* Initialized data */
  .data : 
  {
    . = ALIGN(8);
    _sdata = .;
    *(.data*)
    . = ALIGN(8);
    _edata = .;
  } >RAM


  /* Uninitialized data */
  .bss :
  {
    . = ALIGN(8);
    _sbss = .;
    *(.bss)
    . = ALIGN(8);
    _ebss = .;
  } >RAM
}
