From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [PATCH v3] can: sja1000: Optimise register accesses
Date: Thu, 8 Sep 2016 16:54:36 +0300
Message-ID: <CAEJ7JO1bab+34WEFkgRDmSVvj7Xsin73dH78NL128SVnDLnUcQ@mail.gmail.com>
References: <20160908080613.3997-1-nebaruzdin@gmail.com> <dced7a99-ade8-caf5-22e7-49be91577fbd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36167 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbcIHNy5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2016 09:54:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id s71so2282359oih.3
        for <linux-can@vger.kernel.org>; Thu, 08 Sep 2016 06:54:57 -0700 (PDT)
In-Reply-To: <dced7a99-ade8-caf5-22e7-49be91577fbd@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Sep 8, 2016 at 3:07 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 09/08/2016 10:06 AM, Nikita Edward Baruzdin wrote:
>> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
>> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
>>
>> Thus, this patch introduces [read|write]_reg_rep() interface functions
>> that are used to read/write CAN ID and payload data.
>>
>>   * For plx_pci driver this interface is implemented as
>>     plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
>>     register accesses as much as possible to improve driver performance.
>>
>>   * For other drivers the default implementation,
>>     sja1000_[read|write]_reg_rep(), is used for now. These functions
>>     still access registers in a series of ioread8()/iowrite8() calls.
>>
>> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
>
> Please compile with C=2 and fix these warnings. You need to cast to
> __XXYY if you want to use it in XXYY_to_cpu.

I actually needed to compile with C=2 CF=-D__CHECK_ENDIAN__. Fixed
now, see the new version.

>>   CHECK   /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326:32: warning: incorrect type in assignment (different base types)
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326:32:    expected unsigned int [unsigned] [usertype] <noident>
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326:32:    got restricted __be32 [usertype] <noident>
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331:32: warning: incorrect type in assignment (different base types)
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331:32:    expected unsigned short [unsigned] [short] [usertype] <noident>
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331:32:    got restricted __be16 [usertype] <noident>
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:374:22: warning: cast to restricted __be32
>> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:380:22: warning: cast to restricted __be16
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
