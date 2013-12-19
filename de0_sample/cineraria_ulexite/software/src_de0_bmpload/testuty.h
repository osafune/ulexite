/*********************************************************************
	Cineraria
	�e�X�g�p���[�e�B���e�B 
 *********************************************************************/
#ifndef __testuty_h__
#define __testuty_h__

#include <alt_types.h>

//#define _USE_FATFS


#ifdef _USE_FATFS
  #include "fatfs/vff.h"
  #include "fatfs/diskio.h"

  extern FATFS FatFs_sysobj;		/* File system object */
  extern FIL Mmc_fileobj;			/* File object */

  #define FILE_TOP_DIR	"/DE0/"

/* �t�@�C�����J�� */
  FIL *testfile_open(const char *fname);

/* �������C���[�W���������� */
  void write_binary(
		const char *fname,
		void *ptr,
		int byte
	);

/* �������C���[�W��ǂݍ��� */
  int read_binary(
		const char *fname,
		void *ptr
	);
#endif


/* �V�X�e���C�j�V�����C�Y */
int systeminit(void);

/* �������_���v */
#define DUMPMODE_BYTE		(0)
#define DUMPMODE_WORD		(1)
#define DUMPMODE_DWORD		(2)

void memdump(
		alt_u32 addr,
		int mode
	);


/* CRC16���v�Z */
alt_u16 memcrc16(
		const alt_u8 *p_data,
		int length
	);


#endif
