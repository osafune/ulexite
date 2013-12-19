/* �t�@�C���V�X�e���e�X�g */

// usage:
//  SD�J�[�h��� /DE0/test.bmp ��\������B
//  BMP�t�@�C����480x272�s�N�Z����32bpp�܂���24bpp�J���[ 


#include <stdio.h>
#include <system.h>
#include <io.h>
#include <sys/alt_cache.h>

#include "mmcfs/mmcfs.h"
#include "nd_lib/nd_egl.h"
#include "loadbmp.h"
#include "testuty.h"


int main(void)
{
	alt_u16 *pFrameBuffer;

	// �V�X�e�������� 

	IOWR(LED_7SEG_BASE, 0, ~0x71733d77);	// FPGA�ƕ\������ 
	IOWR(BLCON_BASE, 0, (0<<8));			// �o�b�N���C�gOFF

	systeminit();


	// �t�@�C���V�X�e�������� 

	mmcfs_setup();


	// VGA������ 

	nd_GsVgaInit();

	pFrameBuffer = (alt_u16 *)alt_uncached_malloc(na_VRAM_size);
	if (pFrameBuffer == NULL) {
		printf("[!] Framebuffer assignment failed.\n");
		return -1;
	}

	nd_GsVgaSetBuffer((nd_u32)pFrameBuffer);
	nd_GsEglPage((nd_u32)pFrameBuffer,(nd_u32)pFrameBuffer,0);

	nd_color(nd_COLORGRAY, 0, 256);
	nd_boxfill(0, 0, window_xmax, window_ymax);

	nd_color(nd_COLORWHITE, 0, 256);
	nd_line(0,0, 0,window_ymax);
	nd_color(nd_COLORRED, 0, 256);
	nd_line(window_xmax,0, window_xmax,window_ymax);
	nd_color(nd_COLORLIGHTGREEN, 0, 256);
	nd_line(0,0, window_xmax,0);
	nd_color(nd_COLORBLUE, 0, 256);
	nd_line(0,window_ymax, window_xmax,window_ymax);

	nd_GsVgaScanOn();
	IOWR(BLCON_BASE, 0, (1<<8)|0);		// �o�b�N���C�gON�A�P�x�ő� 


	// �摜��W�J 

	loadbmp("mmcfs:/de0/test.bmp",pFrameBuffer);

	printf("done.\n");
	while(1) {}


	// �I������ 

	nd_GsVgaScanOff();
	alt_uncached_free(pFrameBuffer);


	return 0;
}
