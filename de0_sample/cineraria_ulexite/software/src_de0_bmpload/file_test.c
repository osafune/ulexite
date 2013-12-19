/* ファイルシステムテスト */

// usage:
//  SDカード上の /DE0/test.bmp を表示する。
//  BMPファイルは480x272ピクセルの32bppまたは24bppカラー 


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

	// システム初期化 

	IOWR(LED_7SEG_BASE, 0, ~0x71733d77);	// FPGAと表示する 
	IOWR(BLCON_BASE, 0, (0<<8));			// バックライトOFF

	systeminit();


	// ファイルシステム初期化 

	mmcfs_setup();


	// VGA初期化 

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
	IOWR(BLCON_BASE, 0, (1<<8)|0);		// バックライトON、輝度最大 


	// 画像を展開 

	loadbmp("mmcfs:/de0/test.bmp",pFrameBuffer);

	printf("done.\n");
	while(1) {}


	// 終了処理 

	nd_GsVgaScanOff();
	alt_uncached_free(pFrameBuffer);


	return 0;
}
