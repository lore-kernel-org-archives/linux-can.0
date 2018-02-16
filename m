From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH v2 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
Date: Fri, 16 Feb 2018 12:01:03 +0100
Message-ID: <15d002bb-92a2-20d6-8d49-795785298232@kvaser.com>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <20180216091337.13924-2-jimmyassarsson@gmail.com>
 <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38834 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLBI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 06:01:08 -0500
Received: by mail-lf0-f66.google.com with SMTP id g72so3507236lfg.5
        for <linux-can@vger.kernel.org>; Fri, 16 Feb 2018 03:01:07 -0800 (PST)
In-Reply-To: <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

On 2018-02-16 11:38, Marc Kleine-Budde wrote:
> On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
>> The EAN (article number) combined with serial number form a unique
>> identifier for any Kvaser device. This makes it possible to map netdevice
>> with physical Kvaser device.
>>
>> Example output for USBcan Light 2xHS:
>> $ cat /sys/class/net/can0/ean
>> 7330130007147
>> $ cat /sys/class/net/can0/serial
>> 10659
> 
> Please add sysfs Documentation to Documentation/ABI/testing/

Will this name be OK: Documentation/ABI/testing/sysfs-class-net-kvaser_usb?

>> Tested with the following Kvaser devices:
>> Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
>> Memorator Professional HS/HS and Memorator HS/HS.
>>
>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> 
>> ---
>> Changes in v2:
>>    - Use u64 for ean, instead of u32 ean[2].
>>    - Use the existing sysfs_groups[0], from the net_device.
>>
>>   drivers/net/can/usb/kvaser_usb.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
>> index ee10beaa5da3..0436db1c5d6f 100644
>> --- a/drivers/net/can/usb/kvaser_usb.c
>> +++ b/drivers/net/can/usb/kvaser_usb.c
>> @@ -457,6 +457,8 @@ struct kvaser_usb {
>>   	 * also used as a sentinel for marking free tx contexts.
>>   	 */
>>   	u32 fw_version;
>> +	u32 serial;
>> +	u64 ean;
>>   	unsigned int nchannels;
>>   	unsigned int max_tx_urbs;
>>   	enum kvaser_usb_family family;
>> @@ -692,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvaser_usb *dev)
>>   	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
>>   		return -EINVAL;
>>   
>> +	dev->serial = le32_to_cpu(msg.u.cardinfo.serial_number);
>> +	dev->ean = (u64)(le32_to_cpu(msg.u.cardinfo.ean[1])) << 32 |
>> +		   le32_to_cpu(msg.u.cardinfo.ean[0]);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1802,6 +1808,37 @@ static const struct can_bittiming_const kvaser_usb_bittiming_const = {
>>   	.brp_inc = KVASER_USB_BRP_INC,
>>   };
>>   
>> +static ssize_t serial_show(struct device *dev,
>> +			   struct device_attribute *attr, char *buf)
>> +{
>> +	struct kvaser_usb_net_priv *priv = netdev_priv(to_net_dev(dev));
>> +	struct kvaser_usb *kvaser_dev = priv->dev;
>> +
>> +	return sprintf(buf, "%u\n", kvaser_dev->serial);
>> +}
>> +
>> +static ssize_t ean_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	struct kvaser_usb_net_priv *priv = netdev_priv(to_net_dev(dev));
>> +	struct kvaser_usb *kvaser_dev = priv->dev;
>> +
>> +	return sprintf(buf, "%llx\n", kvaser_dev->ean);
> 
> Do we want leading zeros? How's the ean written on the device?

No, we don't. It's like this 73-30130-00714-7.
