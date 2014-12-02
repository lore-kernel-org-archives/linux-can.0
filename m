From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Tue, 02 Dec 2014 16:08:56 +0100
Message-ID: <547DD608.5090403@peak-system.com>
References: <5477A5A3.9070107@pengutronix.de>
 <547DBAEC.6010903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:58859 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbaLBPJB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 10:09:01 -0500
In-Reply-To: <547DBAEC.6010903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks for your review, Marc.

Please see my acks and comments below...

Regards,

St=C3=A9phane.

Le 02/12/2014 14:13, Marc Kleine-Budde a =C3=A9crit :
>
>
> -------- Original Message --------
> Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters speci=
fic
> files
> Date: Thu, 27 Nov 2014 23:28:51 +0100
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Stephane Grosjean <s.grosjean@peak-system.com>,
> linux-can@vger.kernel.org
> CC: Oliver Hartkopp <socketcan@hartkopp.net>
>
> On 11/27/2014 11:32 AM, Stephane Grosjean wrote:
>> This patch adds 3 new files to add support to the following CAN-FD U=
SB adapters
>> from PEAK-System Technik:
>>
>> PCAN-USB FD             single CAN-FD channel USB adapter
>> PCAN-USB Pro FD         dual CAN-FD channels USB adapter
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>=C2=B2
>> ---
>>   drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955 +++++++++++++++++=
++++++++++++
>>   drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
> Please don't create a header file, if it's only included once. Please
> merge into the correct .c file.

Ok. So I merge both header files into the .c file. There will be only a=
=20
single (and big) pcan_usb_fd.c file.

> Please have a look the _all_ multi-byte values and check for endianes=
s.
>
> Hint, you might want to fix the existing driver first:
>
> pcan_usb_core.c:863:60: warning: restricted __le16 degrades to intege=
r
>
> pcan_usb.c:322:34: warning: cast to restricted __le32
>
> pcan_usb.c:357:20: warning: cast to restricted __le16
>
> pcan_usb.c:382:28: warning: cast to restricted __le16
>
> pcan_usb.c:625:30: warning: cast to restricted __le32
>
> pcan_usb.c:635:30: warning: cast to restricted __le16
>
> pcan_usb_pro.c:158:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:158:28:    expected unsigned int [unsigned] [usertype]
> <noident>
> pcan_usb_pro.c:158:28:    got restricted __le32 [usertype] <noident>
>
> pcan_usb_pro.c:168:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:168:28:    expected unsigned int [unsigned] [usertype]
> <noident>
> pcan_usb_pro.c:168:28:    got restricted __le32 [usertype] <noident>
>
> pcan_usb_pro.c:176:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:176:28:    expected unsigned short [unsigned] [short]
> [usertype] <noident>
> pcan_usb_pro.c:176:28:    got restricted __le16 [usertype] <noident>
>
> pcan_usb_pro.c:182:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:182:28:    expected unsigned short [unsigned] [short]
> [usertype] <noident>
> pcan_usb_pro.c:182:28:    got restricted __le16 [usertype] <noident>
>
> pcan_usb_pro.c:184:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:184:28:    expected unsigned int [unsigned] [usertype]
> <noident>
> pcan_usb_pro.c:184:28:    got restricted __le32 [usertype] <noident>
>
> pcan_usb_pro.c:190:28: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:190:28:    expected unsigned short [unsigned] [short]
> [usertype] <noident>
> pcan_usb_pro.c:190:28:    got restricted __le16 [usertype] <noident>
>
> pcan_usb_pro.c:203:32: warning: incorrect type in assignment (differe=
nt
> base types)
> pcan_usb_pro.c:203:32:    expected unsigned int [unsigned] [usertype]
> <noident>
> pcan_usb_pro.c:203:32:    got restricted __le32 [usertype] <noident>
>
> pcan_usb_pro.c:286:27: warning: cast to restricted __le32
>
> pcan_usb_pro.c:458:30: warning: cast to restricted __le32
>
> pcan_usb_pro.c:550:29: warning: cast to restricted __le32
>
> pcan_usb_pro.c:561:47: warning: cast to restricted __le32
>
> pcan_usb_pro.c:575:32: warning: cast to restricted __le32
>
> pcan_usb_pro.c:605:35: warning: cast to restricted __le32
>
> pcan_usb_pro.c:606:35: warning: cast to restricted __le32
>
> pcan_usb_pro.c:678:47: warning: cast to restricted __le32
>
> pcan_usb_pro.c:696:37: warning: cast to restricted __le32
>
> pcan_usb_pro.c:720:19: warning: cast to restricted __le16
>
>
> Compile your kernel with "make C=3D1 CF=3D-D__CHECK_ENDIAN__", you ne=
et to
> have the tool "sparse" install. On debian/ubuntu/... it's: "sudo
> aptitude install sparse"

Ok, I'll do it too. And I suppose I'll push these changes in a separate=
=20
patch too...

>>   3 files changed, 1271 insertions(+)
>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>   create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.h
>>
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/=
can/usb/peak_usb/pcan_ucan.h
>> new file mode 100644
>> index 0000000..2223c05
>> --- /dev/null
>> +++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
>> @@ -0,0 +1,208 @@
>> +/*
>> + * CAN driver for PEAK System micro-CAN based adapters
>> + *
>> + * Copyright (C) 2003-2011 PEAK System-Technik GmbH
>> + * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-syste=
m.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published
>> + * by the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
>> + * General Public License for more details.
>> + */
>> +#ifndef PUCAN_H
>> +#define PUCAN_H
>> +
>> +/* uCAN commands opcodes list (low-order 10 bits) */
>> +#define PUCAN_CMD_NOP			0x000
>> +#define PUCAN_CMD_RESET_MODE		0x001
>> +#define PUCAN_CMD_NORMAL_MODE		0x002
>> +#define PUCAN_CMD_LISTEN_ONLY_MODE	0x003
>> +#define PUCAN_CMD_TIMING_SLOW		0x004
>> +#define PUCAN_CMD_TIMING_FAST		0x005
>> +#define PUCAN_CMD_FILTER_STD		0x008
>> +#define PUCAN_CMD_TX_ABORT		0x009
>> +#define PUCAN_CMD_WR_ERR_CNT		0x00a
>> +#define PUCAN_CMD_RX_FRAME_ENABLE	0x00b
>> +#define PUCAN_CMD_RX_FRAME_DISABLE	0x00c
>> +#define PUCAN_CMD_END_OF_COLLECTION	0x3ff
>> +
>> +/* uCAN received messages list */
>> +#define PUCAN_MSG_CAN_RX		0x0001
>> +#define PUCAN_MSG_ERROR			0x0002
>> +#define PUCAN_MSG_STATUS		0x0003
>> +#define PUCAN_MSG_BUSLOAD		0x0004
>> +#define PUCAN_MSG_CAN_TX		0x1000
>> +
>> +/* uCAN command common header */
>> +#define PUCAN_CMD_OPCODE(c)		((c)->opcode_channel & 0x3ff)
>> +#define PUCAN_CMD_CHANNEL(c)		((c)->opcode_channel >> 12)
> Please don't hide the pointer deref in a macro. Is this actually used=
?

No, you're right. Both aren't used in fact. Removed.

>
>> +#define PUCAN_CMD_OPCODE_CHANNEL(c, o)	cpu_to_le16(((c) << 12) | ((=
o) & 0x3ff))
> I'm not sure, but I think I don't like hiding of the cpu_to_le16.
> Can you make this a static inline function?

Ok. So I suppose I have to do the same (inline function making) for all=
=20
the other occurrences of "cpu_to_le16()"  in this file, right?

>> +
>> +struct __packed pucan_command {
>> +	u16	opcode_channel;
>> +	u16	args[3];
>> +};
>> +
>> +/* uCAN TIMING_SLOW command fields */
>> +#define PUCAN_TSLOW_SJW_T(s, t)		(((s) & 0xf) | ((!!(t)) << 7))
>> +#define PUCAN_TSLOW_TSEG2(t)		((t) & 0xf)
>> +#define PUCAN_TSLOW_TSEG1(t)		((t) & 0x3f)
>> +#define PUCAN_TSLOW_BRP(b)		cpu_to_le16((b) & 0x3ff)
>> +
>> +struct __packed pucan_timing_slow {
>> +	u16	opcode_channel;
>> +
>> +	u8	ewl;		/* Error Warning limit */
>> +	u8	sjw_t;		/* Sync Jump Width + Triple sampling */
>> +	u8	tseg2;		/* Timing SEGment 2 */
>> +	u8	tseg1;		/* Timing SEGment 1 */
>> +
>> +	u16	brp;		/* BaudRate Prescaler */
>> +};
>> +
>> +/* uCAN TIMING_FAST command fields */
>> +#define PUCAN_TFAST_SJW(s)		((s) & 0x3)
>> +#define PUCAN_TFAST_TSEG2(t)		((t) & 0x7)
>> +#define PUCAN_TFAST_TSEG1(t)		((t) & 0xf)
>> +#define PUCAN_TFAST_BRP(b)		cpu_to_le16((b) & 0x3ff)
>> +
>> +struct __packed pucan_timing_fast {
>> +	u16	opcode_channel;
>> +
>> +	u8	unused;
>> +	u8	sjw;		/* Sync Jump Width */
>> +	u8	tseg2;		/* Timing SEGment 2 */
>> +	u8	tseg1;		/* Timing SEGment 1 */
>> +
>> +	u16	brp;		/* BaudRate Prescaler */
>> +};
>> +
>> +/* uCAN FILTER_STD command fields */
>> +#define PUCAN_FLTSTD_ROW_IDX_BITS	6
>> +
>> +struct __packed pucan_filter_std {
>> +	u16	opcode_channel;
>> +
>> +	u16	idx;
>> +	u32	mask;		/* CAN-ID bitmask in idx range */
>> +};
>> +
>> +/* uCAN WR_ERR_CNT command fields */
>> +#define PUCAN_WRERRCNT_TE(c)		0x4000	/* Tx error cntr write Enable =
*/
>> +#define PUCAN_WRERRCNT_RE(c)		0x8000	/* Rx error cntr write Enable =
*/
> What's the purpose of this   ^
>
> Is this actually used?

No it isn't actually used is this driver. I'll remove them.

>
>> +
>> +struct __packed pucan_wr_err_cnt {
>> +	u16	opcode_channel;
>> +
>> +	u16	sel_mask;
>> +	u8	tx_counter;	/* Tx error counter new value */
>> +	u8	rx_counter;	/* Rx error counter new value */
>> +
>> +	u16	unused;
>> +};
>> +
>> +/* uCAN RX_FRAME_ENABLE command fields */
>> +#define PUCAN_FLTEXT_ERROR		0x0001
>> +#define PUCAN_FLTEXT_BUSLOAD		0x0002
>> +
>> +struct __packed pucan_filter_ext {
>> +	u16	opcode_channel;
>> +
>> +	u16	ext_mask;
>> +	u32	unused;
>> +};
>> +
>> +/* uCAN received messages global format */
>> +struct __packed pucan_msg {
>> +	__le16	size;
>> +	__le16	type;
>> +	__le32	ts_low;
>> +	__le32	ts_high;
>> +};
>> +
>> +/* uCAN flags for CAN/CANFD messages */
>> +#define PUCAN_MSG_SELF_RECEIVE		0x80
>> +#define PUCAN_MSG_ERROR_STATE_IND	0x40	/* error state indicator */
>> +#define PUCAN_MSG_BITRATE_SWITCH	0x20	/* bitrate switch */
>> +#define PUCAN_MSG_EXT_DATA_LEN		0x10	/* extended data length */
>> +#define PUCAN_MSG_SINGLE_SHOT		0x08
>> +#define PUCAN_MSG_LOOPED_BACK		0x04
>> +#define PUCAN_MSG_EXT_ID		0x02
>> +#define PUCAN_MSG_RTR			0x01
>> +
>> +#define PUCAN_MSG_CHANNEL(m)		((m)->channel_dlc & 0xf)
>> +#define PUCAN_MSG_DLC(m)		((m)->channel_dlc >> 4)
>> +
>> +struct __packed pucan_rx_msg {
>> +	__le16	size;
>> +	__le16	type;
>> +	__le32	ts_low;
>> +	__le32	ts_high;
>> +	__le32	tag_low;
>> +	__le32	tag_high;
>> +	u8	channel_dlc;
>> +	u8	client;
>> +	__le16	flags;
>> +	__le32	can_id;
>> +	u8	d[0];
>> +};
>> +
>> +/* uCAN error types */
>> +#define PUCAN_ERMSG_BIT_ERROR		0
>> +#define PUCAN_ERMSG_FORM_ERROR		1
>> +#define PUCAN_ERMSG_STUFF_ERROR		2
>> +#define PUCAN_ERMSG_OTHER_ERROR		3
>> +#define PUCAN_ERMSG_ERR_CNT_DEC		4
>> +
>> +#define PUCAN_ERMSG_CHANNEL(e)		((e)->channel_type_d & 0x0f)
>> +#define PUCAN_ERMSG_ERRTYPE(e)		(((e)->channel_type_d >> 4) & 0x07)
>> +#define PUCAN_ERMSG_D(e)		((e)->channel_type_d & 0x80)
>> +
>> +#define PUCAN_ERMSG_ERRCODE(e)		((e)->code_g & 0x7f)
>> +#define PUCAN_ERMSG_G(e)		((e)->code_g & 0x80)
>> +
>> +struct __packed pucan_error_msg {
>> +	__le16	size;
>> +	__le16	type;
>> +	__le32	ts_low;
>> +	__le32	ts_high;
>> +	u8	channel_type_d;
>> +	u8	code_g;
>> +	u8	tx_err_cnt;
>> +	u8	rx_err_cnt;
>> +};
>> +
>> +#define PUCAN_STMSG_CHANNEL(e)		((e)->channel_p_w_b & 0x0f)
>> +#define PUCAN_STMSG_PASSIVE(e)		((e)->channel_p_w_b & 0x20)
>> +#define PUCAN_STMSG_WARNING(e)		((e)->channel_p_w_b & 0x40)
>> +#define PUCAN_STMSG_BUSOFF(e)		((e)->channel_p_w_b & 0x80)
>> +
>> +struct __packed pucan_status_msg {
>> +	__le16	size;
>> +	__le16	type;
>> +	__le32	ts_low;
>> +	__le32	ts_high;
>> +	u8	channel_p_w_b;
>> +	u8	unused[3];
>> +};
>> +
>> +/* uCAN transmitted message format */
>> +#define PUCAN_MSG_CHANNEL_DLC(c, d)	(((c) & 0xf) | ((d) << 4))
>> +
>> +struct __packed pucan_tx_msg {
>> +	__le16	size;
>> +	__le16	type;
>> +	__le32	tag_low;
>> +	__le32	tag_high;
>> +	u8	channel_dlc;
>> +	u8	client;
>> +	u16	flags;
>> +	__le32	can_id;
>> +	u8	d[0];
>> +};
>> +
>> +#endif
>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/ne=
t/can/usb/peak_usb/pcan_usb_fd.c
>> new file mode 100644
>> index 0000000..3d392a8
>> --- /dev/null
>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>> @@ -0,0 +1,955 @@
>> +/*
>> + * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
>> + *
>> + * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-syste=
m.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License as published
>> + * by the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
>> + * General Public License for more details.
>> + */
>> +#include <linux/netdevice.h>
>> +#include <linux/usb.h>
>> +#include <linux/module.h>
>> +
>> +#include <linux/can.h>
>> +#include <linux/can/dev.h>
>> +#include <linux/can/error.h>
>> +
>> +#include "pcan_usb_core.h"
>> +#include "pcan_usb_fd.h"
>> +
>> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
>> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
>> +
>> +#define ALIGN32(x)			(((x) + 3) & 0xFFFFFFFC)
> Please use http://lxr.free-electrons.com/source/include/linux/kernel.=
h#L49

Ok.

>
>> +
>> +#define PCAN_USBPROFD_CHANNEL_COUNT	2
>> +#define PCAN_USBFD_CHANNEL_COUNT	1
>> +
>> +/* PCAN-USB Pro FD adapter internal clock (MHz) */
>> +#define PCAN_UFD_CRYSTAL_HZ		80000000
>> +
>> +#define PCAN_UFD_CMD_BUFFER_SIZE	512
>> +#define PCAN_UFD_LOSPD_PKT_SIZE		64
>> +
>> +/* PCAN-USB Pro FD command timeout (ms.) */
>> +#define PCAN_UFD_COMMAND_TIMEOUT	1000
>                                   add _MS here, makes it more readabl=
e
Ok.
>> +
>> +/* PCAN-USB Pro FD rx/tx buffers size */
>> +#define PCAN_UFD_RX_BUFFER_SIZE		2048
>> +#define PCAN_UFD_TX_BUFFER_SIZE		512
>> +
>> +/* handle device specific info used by the netdevices */
>> +struct pcan_usb_fd_if {
>> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
>> +	struct peak_time_ref time_ref;
>> +	int cm_ignore_count;
>> +	int dev_opened_count;
>> +};
>> +
>> +/* device information */
>> +struct pcan_usb_fd_device {
>> +	struct peak_usb_device dev;
>> +	struct pcan_usb_fd_if *usb_if;
>> +
>> +	u8 *cmd_buffer_addr;
>> +
>> +	uint tx_error_counter;
>> +	uint rx_error_counter;
>> +};
>> +
>> +/* Clock mode frequence values */
>> +static const u32 pcan_usb_fd_clk_freq[6] =3D {
>> +	[PCAN_UFD_CLK_80MHZ] =3D 80000000,
>> +	[PCAN_UFD_CLK_60MHZ] =3D 60000000,
>> +	[PCAN_UFD_CLK_40MHZ] =3D 40000000,
>> +	[PCAN_UFD_CLK_30MHZ] =3D 30000000,
>> +	[PCAN_UFD_CLK_24MHZ] =3D 24000000,
>> +	[PCAN_UFD_CLK_20MHZ] =3D 20000000
>> +};
>> +
>> +/* functions exported from PCAN-USB Pro interface */
>> +extern int pcan_usb_pro_probe(struct usb_interface *intf);
>> +extern int pcan_usb_pro_send_req(struct peak_usb_device *dev, int r=
eq_id,
>> +				 int req_value, void *req_addr, int req_size);
>> +extern void pcan_usb_pro_restart_complete(struct urb *urb);
> This belongs into a header file. No "extern" though.

Well, ok. But FYI, scripts/checkpatch.pl doesn't like either "extern"=20
keyword in the .h file...

>
>> +
>> +/* return a device USB interface */
>> +static inline
>> +struct pcan_usb_fd_if *pcan_usb_fd_dev_if(struct peak_usb_device *d=
ev)
>> +{
>> +	struct pcan_usb_fd_device *pdev =3D
>> +			container_of(dev, struct pcan_usb_fd_device, dev);
>> +	return pdev->usb_if;
>> +}
>> +
>> +/* return a device USB commands buffer */
>> +static inline void *pcan_usb_fd_cmd_buffer(struct peak_usb_device *=
dev)
>> +{
>> +	struct pcan_usb_fd_device *pdev =3D
>> +			container_of(dev, struct pcan_usb_fd_device, dev);
>> +	return pdev->cmd_buffer_addr;
>> +}
>> +
>> +/* send PCAN-USB Pro FD commands synchronously */
>> +static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *=
cmd_tail)
>> +{
>> +	void *cmd_head =3D pcan_usb_fd_cmd_buffer(dev);
>> +	int actual_length;
>> +	int err, cmd_len;
> cmd_len is a long (or ptrdiff_t), as it's the diff of two pointers.

Ok. So it will be a "ptrdiff_t" .

>
>> +	u8 *packet_ptr;
>> +	int p, n =3D 1, packet_len;
>> +
>> +	/* usb device unregistered? */
>> +	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>> +		return 0;
>> +
>> +	/*
>> +	 * if a packet is not filled completely by commands, the command l=
ist
>> +	 * is terminated with an "end of collection" record.
>> +	 */
>> +	cmd_len =3D cmd_tail - cmd_head;
>> +	if (cmd_len < PCAN_UFD_CMD_BUFFER_SIZE) {
> What happens if cmd_len turns out to be 511?

Well, it can't: "commands" are 64-bits records. The "end of record"=20
"command" must be added when the list of commands doesn't fill the=20
entire buffer content.
Maybe it would be better to write:

    if (cmdlen <=3D (PCAN_UFD_CMD_BUFFER_SIZE - sizeof(u64)) {


instead. What's your opinion about that?

>
>> +		memset(cmd_tail, 0xff, sizeof(u64));
>> +		cmd_len +=3D sizeof(u64);
>> +	}
>> +
>> +	packet_ptr =3D cmd_head;
>> +
>> +	/* firmware is not able to re-assemble 512 bytes buffer in full-sp=
eed */
>> +	if ((dev->udev->speed !=3D USB_SPEED_HIGH) &&
>> +	    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
>> +		packet_len =3D PCAN_UFD_LOSPD_PKT_SIZE;
>> +		n +=3D cmd_len / packet_len;
>> +	} else {
>> +		packet_len =3D cmd_len;
>> +	}
>> +
>> +	for (p =3D 1; p <=3D n; p++) {
> why not the usual, start at 0? (p =3D 0, p < n, p++), or even "i" :)

Well ok no problemo...

>
>> +		err =3D usb_bulk_msg(dev->udev,
>> +				   usb_sndbulkpipe(dev->udev,
>> +						   PCAN_USBPRO_EP_CMDOUT),
>> +				   packet_ptr, packet_len,
>> +				   &actual_length, PCAN_UFD_COMMAND_TIMEOUT);
> Do you have to take care about actual_length? If not, you can pass NU=
LL
> here AFAICS.

Ok, you're right. This parameter can be NULL. Will be changed.

>
>> +		if (err) {
>> +			netdev_err(dev->netdev,
>> +				   "sending command failure: %d\n", err);
>> +			break;
>> +		}
>> +
>> +		packet_ptr +=3D packet_len;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int pcan_usb_fd_set_bus(struct peak_usb_device *dev, u8 onof=
f)
>                                                                 bool =
on

Humm... ok, but be advised that this change will have some side-effects=
=20
on the other existing files (pcan_usb_core.h, pcan_usb.c and=20
pcan_usb_pro.c should be modified accordingly).

>> +{
>> +	struct pucan_command *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +	u16 opcode;
>> +
>> +	if (onoff) {
>> +		opcode =3D (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
>> +				PUCAN_CMD_LISTEN_ONLY_MODE :
>> +				PUCAN_CMD_NORMAL_MODE;
>> +	} else {
>> +		opcode =3D PUCAN_CMD_RESET_MODE;
>> +	}
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx, op=
code);
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
>> +
>> +/*
>> + * Set filtering masks:
>> + *
>> + *	idx in range [0..63] selects row #idx, all rows otherwise.
>> + *	mask in range [0..0xffffffff]
>> + *
>> + */
>> +static int pcan_usb_fd_set_filter_std(struct peak_usb_device *dev, =
int idx,
>> +				      u32 mask)
>> +{
>> +	return 0;
> empty function?

I'm afraid it is... ;-)

>> +}
>> +
>> +/*
>> + * set/unset notifications filter:
>> + *
>> + *	onoff	sets(1)/unset(0) notifications
>> + *	mask	each bit defines a kind of notification to set/unset
>> + */
>> +static int pcan_usb_fd_set_filter_ext(struct peak_usb_device *dev,
>> +				      int onoff, u16 ext_mask, u16 usb_mask)
>> +{
>> +	struct pcan_ufd_filter_ext *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
>> +					(onoff) ? PUCAN_CMD_RX_FRAME_ENABLE :
>> +						  PUCAN_CMD_RX_FRAME_DISABLE);
>> +
>> +	cmd->ext_mask =3D cpu_to_le16(ext_mask);
>> +	cmd->usb_mask =3D cpu_to_le16(usb_mask);
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
>> +
>> +/* setup LED control */
>> +static int pcan_usb_fd_set_can_led(struct peak_usb_device *dev, u8 =
led_mode)
>> +{
>> +	struct pcan_ufd_led *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
>> +						       PCAN_UFD_CMD_LED_SET);
>> +	cmd->mode =3D led_mode;
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
>> +
>> +/* set CAN clock domain */
>> +static int pcan_usb_fd_set_clock_domain(struct peak_usb_device *dev=
,
>> +					u8 clk_mode)
>> +{
>> +	struct pcan_ufd_clock *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
>> +						       PCAN_UFD_CMD_CLK_SET);
>> +	cmd->mode =3D clk_mode;
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
>> +
>> +/* set bittiming for CAN and CAN-FD header */
>> +static int pcan_usb_fd_set_bittiming_slow(struct peak_usb_device *d=
ev,
>> +					  struct can_bittiming *bt)
>> +{
>> +	struct pucan_timing_slow *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
>> +						       PUCAN_CMD_TIMING_SLOW);
>> +	cmd->sjw_t =3D PUCAN_TSLOW_SJW_T(bt->sjw - 1,
>> +				dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
>> +
>> +	cmd->tseg2 =3D PUCAN_TSLOW_TSEG2(bt->phase_seg2 - 1);
>> +	cmd->tseg1 =3D PUCAN_TSLOW_TSEG1(bt->prop_seg + bt->phase_seg1 - 1=
);
>> +	cmd->brp =3D PUCAN_TSLOW_BRP(bt->brp - 1);
>> +
>> +	cmd->ewl =3D 96;	/* default */
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
>> +
>> +/* set CAN-FD bittiming for data */
>> +static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *d=
ev,
>> +					  struct can_bittiming *bt)
>> +{
>> +	struct pucan_timing_fast *cmd =3D pcan_usb_fd_cmd_buffer(dev);
>> +
>> +	cmd->opcode_channel =3D PUCAN_CMD_OPCODE_CHANNEL(dev->ctrl_idx,
>> +						       PUCAN_CMD_TIMING_FAST);
>> +	cmd->sjw =3D PUCAN_TFAST_SJW(bt->sjw - 1);
>> +	cmd->tseg2 =3D PUCAN_TFAST_TSEG2(bt->phase_seg2 - 1);
>> +	cmd->tseg1 =3D PUCAN_TFAST_TSEG1(bt->prop_seg + bt->phase_seg1 - 1=
);
>> +	cmd->brp =3D PUCAN_TFAST_BRP(bt->brp - 1);
>> +
>> +	/* send the command */
>> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
>> +}
> Marc
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
