From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [PATCH v3] can: sja1000: Optimise register accesses
Date: Thu, 8 Sep 2016 14:10:24 +0300
Message-ID: <CAEJ7JO0fUdE0f0KJ7erf0QHayd8DThF5py96CNwm97pGna2OoA@mail.gmail.com>
References: <20160908080613.3997-1-nebaruzdin@gmail.com> <20160908113607.7b7e7ca8@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34769 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbcIHLKp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2016 07:10:45 -0400
Received: by mail-oi0-f50.google.com with SMTP id m11so65590856oif.1
        for <linux-can@vger.kernel.org>; Thu, 08 Sep 2016 04:10:45 -0700 (PDT)
In-Reply-To: <20160908113607.7b7e7ca8@brick.gerasiov.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Gerasiov <gq@redlab-i.ru>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Sep 8, 2016 at 11:36 AM, Alexander Gerasiov <gq@redlab-i.ru> wrote:
> Hello Nikita,
>
> On Thu,  8 Sep 2016 11:06:13 +0300
> Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:
>
>> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
>> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
>>
>> Thus, this patch introduces [read|write]_reg_rep() interface functions
>> that are used to read/write CAN ID and payload data.
>>
>>   * For plx_pci driver this interface is implemented as
>>     plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
>>     register accesses as much as possible to improve driver
>> performance.
>>
>>   * For other drivers the default implementation,
>>     sja1000_[read|write]_reg_rep(), is used for now. These functions
>>     still access registers in a series of ioread8()/iowrite8() calls.
>
> This looks OK for me. (I hope you didn't forget to run tests with this
> variant. And with default implementation of rep functions too.)

Sure, I've tested both plx_pci_[read|write]_reg_rep() and
sja1000_[read|write]_reg_rep() implementations, meaning that candump shows the
same frame info for both sender and receiver CAN interfaces, as I specify in a
cansend command. I've also checked that results from the table in my first
email are still true.

> It would be good if someone run tests with other plx_pci based adapters
> (they should also work with 32 bit access via PCI, but who knows).
> Tests with other sja1000 cards and on big-endian boxes are welcome too.
>
>
>
> --
> Best regards,
>  Alexander Gerasiov
>
>  Contacts:
>  e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
>  PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
