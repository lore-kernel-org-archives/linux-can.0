From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can.h: make padding given by gcc explicit
Date: Tue, 05 May 2015 21:02:07 +0200
Message-ID: <554913AF.6080003@hartkopp.net>
References: <554797BA.6080506@hartkopp.net> <1430842036-21509-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14888 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbbEETCN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 May 2015 15:02:13 -0400
In-Reply-To: <1430842036-21509-1-git-send-email-shawn@churchofgit.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

On 05/05/2015 06:07 PM, Shawn Landden wrote:
> The current definition of struct can_frame has a 16-byte size, with 8-byte
> alignment, but the 3 bytes of padding are not explicit like the similar 2 bytes
> of padding of struct canfd_frame. Make it explicit so it is easier to read.
> 
> v2: match analogous padding fields in canfd_frame
>     update Documentation
> 
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Shawn!

> ---
>  Documentation/networking/can.txt | 3 +++
>  include/uapi/linux/can.h         | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
> index 5abad1e..b48d4a1 100644
> --- a/Documentation/networking/can.txt
> +++ b/Documentation/networking/can.txt
> @@ -268,6 +268,9 @@ solution for a couple of reasons:
>      struct can_frame {
>              canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>              __u8    can_dlc; /* frame payload length in byte (0 .. 8) */
> +            __u8    __pad;   /* padding */
> +            __u8    __res0;  /* reserved / padding */
> +            __u8    __res1;  /* reserved / padding */
>              __u8    data[8] __attribute__((aligned(8)));
>      };
>  
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 41892f7..9692cda 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -95,11 +95,17 @@ typedef __u32 can_err_mask_t;
>   * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
>   *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
>   *           mapping of the 'data length code' to the real payload length
> + * @__pad:   padding
> + * @__res0:  reserved / padding
> + * @__res1:  reserved / padding
>   * @data:    CAN frame payload (up to 8 byte)
>   */
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>  	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
> +	__u8    __pad;   /* padding */
> +	__u8    __res0;  /* reserved / padding */
> +	__u8    __res1;  /* reserved / padding */
>  	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>  };
>  
> 
