From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] [RFC] can: add CAN interface termination API
Date: Sun, 8 Jan 2017 17:09:21 +0100
Message-ID: <3aa5406e-63b8-a634-bf9d-23e64de3fcdd@hartkopp.net>
References: <20170107195807.16423-1-socketcan@hartkopp.net>
 <CAKT-o-ddkBw8qo86DopN-VBDTx3qjUVg1FCWCwaSqTDaFF1VbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:19594 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdAHQJ1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Jan 2017 11:09:27 -0500
In-Reply-To: <CAKT-o-ddkBw8qo86DopN-VBDTx3qjUVg1FCWCwaSqTDaFF1VbQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

Hi Remik,

On 01/08/2017 04:22 PM, Kołłątaj, Remigiusz wrote:

>> +       if (data[IFLA_CAN_TERMINATION]) {
>> +               u16 t = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>> +               int num_t = priv->termination_const_size / sizeof(u16);
>> +               int i;
>> +
>> +               /* check whether given value is supported by the interface */
>> +               for (i = 0; i < num_t && t != priv->termination_const[i]; i++);
>> +               if (i >= num_t)
>> +                       return -EINVAL;
>> +
>> +               priv->termination = t;
>
> I would update the value after successful call to do_set_termination.

Sounds good.

Then I would change the do_set_termination() prototype:

	int (*do_set_termination)(struct net_device *dev);
to
	int (*do_set_termination)(struct net_device *dev, u16 term);


>> +/* termination range: 1..65534 Ohms */
>> +#define CAN_TERMINATION_DISABLED 0xFFFFU
>> +
>
> 0 seems more natural to me. Why you are using 0xFFFF?

I was initially thinking about a zero terminated array of termination 
values. But now we have a termination_const_size which allows to walk 
through the array without a trailing zero.

I'll change it to

+#define CAN_TERMINATION_DISABLED 0

Thanks,
Oliver
