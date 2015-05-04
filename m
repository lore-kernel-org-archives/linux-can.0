From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can.h: make padding given by gcc explicit
Date: Mon, 04 May 2015 18:00:58 +0200
Message-ID: <554797BA.6080506@hartkopp.net>
References: <1430510060-3504-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:55211 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbbEDQBE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 May 2015 12:01:04 -0400
In-Reply-To: <1430510060-3504-1-git-send-email-shawn@churchofgit.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Shawn,

fortunately some camping sites have free WLAN :-)

Usually the user space API (== ABI) is written into stone but making the
implicite padding more explicit looks good from my side.

The problem was, that in the early days of SocketCAN people would have seen
this kind of 'free space' as an invitation to put bogus stuff like CAN
controller mailbox indices here %-(

To be somehow analogue to the struct canfd_frame I would suggest this layout:

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 41892f7..9692cda 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -95,11 +95,17 @@ typedef __u32 can_err_mask_t;
  * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
  *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
  *           mapping of the 'data length code' to the real payload length
+ * @__pad:   padding
+ * @__res0:  reserved / padding
+ * @__res1:  reserved / padding
  * @data:    CAN frame payload (up to 8 byte)
  */
 struct can_frame {
        canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
        __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
+       __u8    __pad;   /* padding */
+       __u8    __res0;  /* reserved / padding */
+       __u8    __res1;  /* reserved / padding */
        __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 

And when providing a an update of this central data structure the references
in Documentation/networking/can.txt have to be updated too :-)

@Marc: Do you have any objections to add this padding stuff?

Regards,
Oliver

ps. I don't know when I will be online next time. But net-next is not closing until
I'm back to work ... no hurry.

On 05/01/2015 09:54 PM, Shawn Landden wrote:
> The current definition of struct can_frame has a 16-byte size, with 8-byte
> alignment, but the 3 bytes of padding are not explicit like the similar 2 bytes
> of padding of struct canfd_frame. Make it explicit so it is easier to read.
> 
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
>  include/uapi/linux/can.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 41892f7..bc1b937 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -100,6 +100,7 @@ typedef __u32 can_err_mask_t;
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>  	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
> +        __u8    __res[3];/* reserved / padding */
>  	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>  };
>  
> 
