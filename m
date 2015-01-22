From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 17:19:08 +0100
Message-ID: <54C122FC.9030806@hartkopp.net>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com> <54C11A1B.4090100@pengutronix.de> <54C11E4A.3090303@peak-system.com> <54C1218D.80006@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:48872 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbAVQTX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 11:19:23 -0500
In-Reply-To: <54C1218D.80006@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org



On 22.01.2015 17:13, Marc Kleine-Budde wrote:
> On 01/22/2015 04:59 PM, Stephane Grosjean wrote:
>>
>> Le 22/01/2015 16:41, Marc Kleine-Budde a =C3=A9crit :
>>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>>> Add support for the following new PEAK-System technik CANFD USB ad=
apters:
>>>>
>>>> PCAN-USB FD             single CANFD channel USB adapter
>>>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>>>
>>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> [...]
>>>
>>>> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/=
net/can/usb/peak_usb/pcan_usb_fd.c
>>>> new file mode 100644
>>>> index 0000000..2129549
>>>> --- /dev/null
>>>> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>>> [...]
>>>
>>>> +/* handle device specific info used by the netdevices */
>>>> +struct pcan_usb_fd_if {
>>>> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
>>>> +	struct pcan_ufd_fw_info fw_info;
>>>> +	struct peak_time_ref    time_ref;
>>>> +	int                     cm_ignore_count;
>>>> +	int                     dev_opened_count;
>>> Please use tab for indention, not space.
>>>
>>>> +};
>>>> +
>>>> +/* device information */
>>>> +struct pcan_usb_fd_device {
>>>> +	struct peak_usb_device  dev;
>>>> +	struct can_berr_counter bec;
>>>> +	struct pcan_usb_fd_if  *usb_if;
>>>> +	u8                     *cmd_buffer_addr;
>>> dito
>>>
>>> Marc
>>>
>> Well, I'm afraid I have misunderstood one of your previous reMarks:
>>
>>> +/* device information */
>>> +struct pcan_usb_fd_device {
>>> +	struct peak_usb_device	dev;
>>> +	struct pcan_usb_fd_if *	usb_if;
>>> 	struct pcan_usb_fd_if *usb_if
>>>> +
>>>> +	u8 *	cmd_buffer_addr;
>>> 	u8 *cmd_buffer_addr
>>>> +
>>>> +	uint	tx_error_counter;
>>>> +	uint	rx_error_counter;
>>> 	unsigned int
>>>
>>> Please don't use a tab after the struct foo, u8, unsinged int, etc.=
=2E.,
>>> as it doesn't align.
>>>
>>
>> can u explain a bit more, please ? FYI, checkpatch.pl doesn't see an=
y
>> warning nor fatal in these indentations...
>
> You have decided for indention in structs in your files, if you do so=
,
> please use TABs consistently everywhere. (Or don't do indention at al=
l.)
>

I thought between the data type and the variable name is just sonly one=
 single=20
space.

So

+struct __packed pucan_timing_slow {
+	__le16	opcode_channel;
+
+	u8	ewl;		/* Error Warning limit */
+	u8	sjw_t;		/* Sync Jump Width + Triple sampling */
+	u8	tseg2;		/* Timing SEGment 2 */
+	u8	tseg1;		/* Timing SEGment 1 */
+
+	__le16	brp;		/* BaudRate Prescaler */
+};

becomes

+struct __packed pucan_timing_slow {
+	__le16 opcode_channel;
+
+	u8 ewl;		/* Error Warning limit */
+	u8 sjw_t;	/* Sync Jump Width + Triple sampling */
+	u8 tseg2;	/* Timing SEGment 2 */
+	u8 tseg1;	/* Timing SEGment 1 */
+
+	__le16 brp;	/* BaudRate Prescaler */
+};

With tabs indenting u8 from the start of the line and tabs before the c=
omment.

Regards,
Oliver


