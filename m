From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 11:32:33 +0100
Message-ID: <a925cc41-9719-1bad-ae75-0a9e8b7dde24@kvaser.com>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33038 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbeBPKch (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 05:32:37 -0500
Received: by mail-lf0-f66.google.com with SMTP id j193so3439081lfe.0
        for <linux-can@vger.kernel.org>; Fri, 16 Feb 2018 02:32:36 -0800 (PST)
In-Reply-To: <588ce8c3-5a21-b678-50b2-a9d9d6949d63@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

On 2018-02-16 11:24, Marc Kleine-Budde wrote:
> On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
>> serial_number_high can be removed from the struct since it is never used in
>> the USBcan II firmware.
>>
>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>> ---
>> Changes in v2:
>>    - Made this a separate patch.
>>
>>   drivers/net/can/usb/kvaser_usb.c | 16 ++++------------
>>   1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
>> index 63587b8e6825..ee10beaa5da3 100644
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
> 
> Nitpick: This doesn't belong into this patch. Please use __le32 instead
> of u32.

Oh, my bad. Should I post an updated version of the patch?

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
>>
> 
> Otherwise good.
> 
> Marc
