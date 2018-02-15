From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH] can: kvaser_usb: Expose EAN and serial number via sysfs
Date: Thu, 15 Feb 2018 17:49:09 +0100
Message-ID: <a89fd5a7-786f-0069-55d1-310df0137a0c@kvaser.com>
References: <20180215155851.7584-1-jimmyassarsson@gmail.com>
 <0749979a-a060-6057-b8e1-3cbd8c24834a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35179 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426505AbeBOQtO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Feb 2018 11:49:14 -0500
Received: by mail-lf0-f65.google.com with SMTP id a204so431404lfa.2
        for <linux-can@vger.kernel.org>; Thu, 15 Feb 2018 08:49:13 -0800 (PST)
In-Reply-To: <0749979a-a060-6057-b8e1-3cbd8c24834a@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

On 2018-02-15 17:28, Marc Kleine-Budde wrote:
> On 02/15/2018 04:58 PM, Jimmy Assarsson wrote:
>> The EAN (article number) combined with serial number form a unique
>> identifier for any Kvaser device. This makes it possible to map netdevice
>> with physical Kvaser device.
>>
>> The struct kvaser_msg_cardinfo can be simplified, since serial_number_high
>> is never used in firmware, for USBcan II devices.
> 
> Please make this a separate patch -> 1/2.

Sure.

>>
>> Example output for USBcan Light 2xHS:
>> $ cat /sys/class/net/can0/device/ean
>> 7330130007147
>> $ cat /sys/class/net/can0/device/serial
>> 10659
>>
>> Tested with the following Kvaser devices:
>> Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
>> Memorator Professional HS/HS and Memorator HS/HS.
>>
>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>> ---
>>   drivers/net/can/usb/kvaser_usb.c | 63 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 51 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
>> index 63587b8e6825..b03f5723a343 100644
>> --- a/drivers/net/can/usb/kvaser_usb.c
>> +++ b/drivers/net/can/usb/kvaser_usb.c
>> @@ -196,19 +196,11 @@ struct kvaser_msg_simple {
>>   struct kvaser_msg_cardinfo {
>>   	u8 tid;
>>   	u8 nchannels;
>> -	union {
>> -		struct {
>> -			__le32 serial_number;
>> -			__le32 padding;
>> -		} __packed leaf0;
>> -		struct {
>> -			__le32 serial_number_low;
>> -			__le32 serial_number_high;
>> -		} __packed usbcan0;
>> -	} __packed;
>> +	__le32 serial_number;
>> +	__le32 padding0;
>>   	__le32 clock_resolution;
>>   	__le32 mfgdate;
>> -	u8 ean[8];
>> +	u32 ean[2];
>>   	u8 hw_revision;
>>   	union {
>>   		struct {
>> @@ -218,7 +210,7 @@ struct kvaser_msg_cardinfo {
>>   			u8 padding;
>>   		} __packed usbcan1;
>>   	} __packed;
>> -	__le16 padding;
>> +	__le16 padding1;
>>   } __packed;
>>   
>>   struct kvaser_msg_cardinfo2 {
>> @@ -465,6 +457,8 @@ struct kvaser_usb {
>>   	 * also used as a sentinel for marking free tx contexts.
>>   	 */
>>   	u32 fw_version;
>> +	u32 serial;
>> +	u32 ean[2];
> u64?
>>   	unsigned int nchannels;
>>   	unsigned int max_tx_urbs;
>>   	enum kvaser_usb_family family;
>> @@ -700,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvaser_usb *dev)
>>   	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
>>   		return -EINVAL;
>>   
>> +	dev->serial = le32_to_cpu(msg.u.cardinfo.serial_number);
>> +	dev->ean[0] = le32_to_cpu(msg.u.cardinfo.ean[0]);
>> +	dev->ean[1] = le32_to_cpu(msg.u.cardinfo.ean[1]);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1985,6 +1983,38 @@ static int kvaser_usb_get_endpoints(const struct usb_interface *intf,
>>   	return -ENODEV;
>>   }
>>   
>> +static ssize_t serial_show(struct device *dev,
>> +			   struct device_attribute *attr, char *buf)
>> +{
>> +	struct usb_interface *intf = to_usb_interface(dev);
>> +	struct kvaser_usb *kvaser_dev = usb_get_intfdata(intf);
>> +
>> +	return sprintf(buf, "%u\n", kvaser_dev->serial);
>> +}
>> +
>> +static ssize_t ean_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	struct usb_interface *intf = to_usb_interface(dev);
>> +	struct kvaser_usb *kvaser_dev = usb_get_intfdata(intf);
>> +
>> +	return sprintf(buf, "%x%x\n", kvaser_dev->ean[1], kvaser_dev->ean[0]);
> 
> What happens if there are leading '0' in ean[0]? Using a u64 would fix
> this, too.

True. Will change to u64.

>> +}
>> +
>> +static DEVICE_ATTR_RO(serial);
>> +static DEVICE_ATTR_RO(ean);
>> +
>> +static struct attribute *kvaser_usb_dev_attrs[] = {
>> +	&dev_attr_serial.attr,
>> +	&dev_attr_ean.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group kvaser_usb_dev_group = {
>> +	.name = NULL,
>> +	.attrs = kvaser_usb_dev_attrs,
>> +};
>> +
>>   static int kvaser_usb_probe(struct usb_interface *intf,
>>   			    const struct usb_device_id *id)
>>   {
>> @@ -2048,10 +2078,18 @@ static int kvaser_usb_probe(struct usb_interface *intf,
>>   		return err;
>>   	}
>>   
>> +	err = sysfs_create_group(&intf->dev.kobj, &kvaser_usb_dev_group);
>> +	if (err) {
>> +		dev_err(&intf->dev, "Cannot create sysfs group %d\n", err);
>> +		return err;
>> +	}
>> +
> 
> Why don't you use the existing dev->sysfs_groups[0]?
> 
> See the at91 driver for example:
> 
> http://lxr.bootlin.com/linux/latest/source/drivers/net/can/at91_can.c#L1341

Much nicer. Thanks!

>>   	for (i = 0; i < dev->nchannels; i++) {
>>   		err = kvaser_usb_init_one(intf, id, i);
>>   		if (err) {
>>   			kvaser_usb_remove_interfaces(dev);
>> +			sysfs_remove_group(&intf->dev.kobj,
>> +					   &kvaser_usb_dev_group);
>>   			return err;
>>   		}
>>   	}
>> @@ -2063,6 +2101,7 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
>>   {
>>   	struct kvaser_usb *dev = usb_get_intfdata(intf);
>>   
>> +	sysfs_remove_group(&intf->dev.kobj, &kvaser_usb_dev_group);
>>   	usb_set_intfdata(intf, NULL);
>>   
>>   	if (!dev)
>>
> 
> Marc
