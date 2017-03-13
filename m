From: Lars Susaas <larssusaas@gmail.com>
Subject: Re: How to get device supported ctrl modes from userspace
Date: Mon, 13 Mar 2017 22:26:40 +0100
Message-ID: <CALHGA=tXJtAH=ygvJZ15xe=Nzs_K-72tP+sF_T4hkBXDSVgLWA@mail.gmail.com>
References: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
 <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35242 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdCMV0m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 17:26:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id b129so70484125pgc.2
        for <linux-can@vger.kernel.org>; Mon, 13 Mar 2017 14:26:41 -0700 (PDT)
In-Reply-To: <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

>> I would like find out how to get information about which control modes
>> the device supports from userspace.
>> Ctrlmode as in CAN_CTRLMODE_LISTENONLY
>>
>> In the driver code is looks like it is found in
>> priv->can.ctrlmode_supported, but how do i get it from userspace?
>>
>> I am unable to find any information about this.
>
> You could probe the mode. If it's not supported, EOPNOTSUP will be returned:
>
>   # ip -d -s link set can0 type can one-shot on
>   RTNETLINK answers: Operation not supported

Thanks for the tip, it works!
For the record, trying to turn the modes off instead of on have the
same results and work with can-fd out of the box.

> Thinking about it... It would be nice to list the supported modes with:
>
>   # ip -d link show can0

Yes, that is what i was dreaming/looking for :)
