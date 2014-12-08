From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 8 Dec 2014 04:26:26 -0800
Message-ID: <20141208122626.GA8858@hudson.localdomain>
References: <1418038572-4284-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48819 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbaLHM0a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Dec 2014 07:26:30 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so5143034pab.12
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2014 04:26:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418038572-4284-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

Stephane,

On Mon, Dec 08, 2014 at 12:36:12PM +0100, Stephane Grosjean wrote:
> Add support for the following new PEAK-System technik CANFD USB adapters:
> 
> PCAN-USB FD             single CANFD channel USB adapter
> PCAN-USB Pro FD         dual CANFD channels USB adapter
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
> v2: removes 2 changes that have been erroneously included in
>     peak_usb_create_dev() (-netdev->dev_id = ctrl_idx;) as well as in
>     peak_usb_probe() (move of "const u16 usb_id_product" declaration) in the
>     previous version of this patch.
> 
>  drivers/net/can/usb/Kconfig                  |   14 +-
[...]
> +};
> +
> +#define PCAN_UFD_MSG_OVERRUN		0x101
> +
> +#define PCAN_UFD_OVMSG_CHANNEL(o)	((o)->channel & 0xf)
> +
> +struct __packed pcan_ufd_ovr_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	u8	channel;
> +	u8	unused[3];
> +};
> +
> +/* Clock mode frequence values */
                 ^^^^^^^^^
				 frequency

> +static const u32 pcan_usb_fd_clk_freq[6] = {
> +	[PCAN_UFD_CLK_80MHZ] = 80000000,
> +	[PCAN_UFD_CLK_60MHZ] = 60000000,
> +	[PCAN_UFD_CLK_40MHZ] = 40000000,
> +	[PCAN_UFD_CLK_30MHZ] = 30000000,
> +	[PCAN_UFD_CLK_24MHZ] = 24000000,
> +	[PCAN_UFD_CLK_20MHZ] = 20000000
> +};
> +
> +/* build the opcode_channel field wth respect to the correct endianess */
                                     ^^^
									 with

> +static inline __le16 pucan_cmd_opcode_channel(int opcode, int channel)
> +{
> +	return cpu_to_le16(PUCAN_CMD_OPCODE_CHANNEL(opcode, channel));
> +}
> +
> +/* return a device USB interface */
> +static inline
> +struct pcan_usb_fd_if *pcan_usb_fd_dev_if(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_fd_device *pdev =
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	return pdev->usb_if;
> +}
[...]

-- 
- Jeremiah Mahler
