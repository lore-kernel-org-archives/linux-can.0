From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Fri, 30 Jan 2015 22:56:25 +0100
Message-ID: <54CBFE09.9000700@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com> <52DFC08C.2040400@universalnet.at> <52DFD9B7.40300@pengutronix.de> <52E36208.3020100@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050300080902080209090706"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:13069 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbA3V4l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Jan 2015 16:56:41 -0500
In-Reply-To: <52E36208.3020100@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: Gediminas Simanskis <gediminas@8devices.com>, linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300080902080209090706
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bernd,

I had an adapter with a firmware < v1.5 here and tried to follow the 
documentation at

https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental

Unfortunately the referenced patch at
http://lists.gnumonks.org/pipermail/dfu-util/attachments/20140124/1abbc049/attachment.bin
disappeared ...

I had this patch somewhere on my former laptop and attached it for the records.

As dfu-util moved to to gitorious I cloned the dfu-util master into

https://gitorious.org/dfu-util/8devices-usb2can-dfu-util

an applied the two patches so that this version is able to flash the 8devices 
USB2CAN adapter again.

Regards,
Oliver

On 25.01.2014 08:04, Bernd Krumboeck wrote:
> Hi!
>
>
> Source code from firmware v1.5: https://github.com/krumboeck/usb2can_firmware
>
>
> After some experiments I was able to flash the firmware with dfu-util under
> linux:
> https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental
>
>
> Sadly I don't know the way how to build the firmware with a free tools chain.
>
>
> regards,
> Bernd
>
>
> Am 2014-01-22 15:46, schrieb Marc Kleine-Budde:
>> On 01/22/2014 01:58 PM, Bernd Krumboeck wrote:
>>> May I kindly ask you to send me a diff/patch about the changes, so I can
>>> update the firmware sources on github.
>>
>> A complete new set of sources will do, too. Git will create the diff for
>> you. :)
>>
>> Marc
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------050300080902080209090706
Content-Type: text/x-patch;
 name="dfu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dfu.patch"

diff --git a/src/dfuse.c b/src/dfuse.c
index 1ee6575..77648c2 100644
--- a/src/dfuse.c
+++ b/src/dfuse.c
@@ -248,6 +248,9 @@ int dfuse_special_command(struct dfu_if *dif, unsigned int address,
 	}
 	milli_sleep(dst.bwPollTimeout);
 
+	if (command == SET_ADDRESS)
+		return ret;
+
 	ret = dfu_abort(dif->dev_handle, dif->interface);
 	if (ret < 0) {
 		errx(EX_IOERR, "Error sending dfu abort request");
@@ -401,11 +404,18 @@ int dfuse_dnload_element(struct dfu_if *dif, unsigned int dwElementAddress,
 			dwElementAddress + dwElementSize - 1);
 	}
 
+	for (p = 0; p < (int)dwElementSize;) {
+		unsigned int address = dwElementAddress + p;
+		segment = find_segment(mem_layout, address);
+		if ((segment->memtype & DFUSE_ERASABLE) && !dfuse_mass_erase) {
+			dfuse_special_command(dif, address, ERASE_PAGE);
+		}
+		p = p + segment->pagesize;
+	}
+
 	dfu_progress_bar("Download", 0, 1);
 
 	for (p = 0; p < (int)dwElementSize; p += xfer_size) {
-		int page_size;
-		unsigned int erase_address;
 		unsigned int address = dwElementAddress + p;
 		int chunk_size = xfer_size;
 
@@ -414,35 +424,11 @@ int dfuse_dnload_element(struct dfu_if *dif, unsigned int dwElementAddress,
 			errx(EX_IOERR, "Page at 0x%08x is not writeable",
 				address);
 		}
-		page_size = segment->pagesize;
 
 		/* check if this is the last chunk */
 		if (p + chunk_size > (int)dwElementSize)
 			chunk_size = dwElementSize - p;
 
-		/* Erase only for flash memory downloads */
-		if ((segment->memtype & DFUSE_ERASABLE) && !dfuse_mass_erase) {
-			/* erase all involved pages */
-			for (erase_address = address;
-			     erase_address < address + chunk_size;
-			     erase_address += page_size)
-				if ((erase_address & ~(page_size - 1)) !=
-				    last_erased_page)
-					dfuse_special_command(dif,
-							      erase_address,
-							      ERASE_PAGE);
-
-			if (((address + chunk_size - 1) & ~(page_size - 1)) !=
-			    last_erased_page) {
-				if (verbose > 2)
-					printf(" Chunk extends into next page,"
-					       " erase it as well\n");
-				dfuse_special_command(dif,
-						      address + chunk_size - 1,
-						      ERASE_PAGE);
-			}
-		}
-
 		if (verbose) {
 			printf(" Download from image offset "
 			       "%08x to memory %08x-%08x, size %i\n",

--------------050300080902080209090706
Content-Type: text/x-patch;
 name="dfu-remove-vendor-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dfu-remove-vendor-check.patch"

diff --git a/src/main.c b/src/main.c
index 30a9bd8..516a460 100644
--- a/src/main.c
+++ b/src/main.c
@@ -655,16 +655,6 @@ status_again:
 		break;
 
 	case MODE_DOWNLOAD:
-		if (((file.idVendor  != 0xffff && file.idVendor  != runtime_vendor) ||
-		     (file.idProduct != 0xffff && file.idProduct != runtime_product)) &&
-		    ((file.idVendor  != 0xffff && file.idVendor  != dfu_root->vendor) ||
-		     (file.idProduct != 0xffff && file.idProduct != dfu_root->product))) {
-			errx(EX_IOERR, "Error: File ID %04x:%04x does "
-				"not match device (%04x:%04x or %04x:%04x)",
-				file.idVendor, file.idProduct,
-				runtime_vendor, runtime_product,
-				dfu_root->vendor, dfu_root->product);
-		}
 		if (dfuse_device || dfuse_options || file.bcdDFU == 0x11a) {
 		        if (dfuse_do_dnload(dfu_root, transfer_size, &file,
 							dfuse_options) < 0)

--------------050300080902080209090706--
