From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: J1939: /proc/net/can interface
Date: Wed, 17 Jun 2020 15:03:45 +0200
Message-ID: <86064094-05f7-edc7-db98-d3c9d41592b0@pengutronix.de>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
 <20200617125949.GA12583@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFQNDv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 09:03:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F17DC06174E
        for <linux-can@vger.kernel.org>; Wed, 17 Jun 2020 06:03:51 -0700 (PDT)
In-Reply-To: <20200617125949.GA12583@x1.vandijck-laurijssen.be>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnej Duranovic <arnejduranovic@pm.me>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 6/17/20 2:59 PM, Kurt Van Dijck wrote:
>> + 6. /proc/net/can-j1939 Interface.
>> + --------------------------------
>> +
>> +   Files giving you a view on the in-kernel operation of J1939 are located at:
>> +   /proc/net/j1939.
>> +
>> + 6.1 /proc/net/can-j1939/ecu
>> +
>> +   This file gives an overview of the known ECU's to the kernel.
>> +   - iface : network interface they operate on.
>> +   - SA : current address.
>> +   - name : 64bit NAME
>> +   - flags : 'L' = local, 'R' = remote
>>
>> I am interested in what happened to this feature since I do not see it in the latest implementation or in the documentation?
> 
> The feature got removed, as (almost) all of the /proc interface
> for making mainline integration easier.
> The idea was to restore the required interfaces when necessary.

...or rather use something modern and machine readable.

>> I am interested in retrieving "known ECU's to the kernel" in the latest implementation. What is recommended?
> 
> I understand your question. The simple answer right now is: there isn't.
> 
> we could debate about this being necessary in /proc,
> or rather in debugfs,
> since this knowledge should not be used in real applications?
> Am I right that your intended use is debugging related?

Today we probably want to have a netlink interface to read that information from
the kernel.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
