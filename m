From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: How to get device supported ctrl modes from userspace
Date: Thu, 9 Mar 2017 22:52:19 +0100
Message-ID: <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com>
References: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:57024 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdCIVwX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 16:52:23 -0500
In-Reply-To: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars Susaas <larssusaas@gmail.com>, linux-can@vger.kernel.org

Hello Lars,

Am 09.03.2017 um 21:38 schrieb Lars Susaas:
> Hi,
>
> I would like find out how to get information about which control modes
> the device supports from userspace.
> Ctrlmode as in CAN_CTRLMODE_LISTENONLY
>
> In the driver code is looks like it is found in
> priv->can.ctrlmode_supported, but how do i get it from userspace?
>
> I am unable to find any information about this.

You could probe the mode. If it's not supported, EOPNOTSUP will be returned:

   # ip -d -s link set can0 type can one-shot on
   RTNETLINK answers: Operation not supported

Thinking about it... It would be nice to list the supported modes with:

   # ip -d link show can0

Wolfgang.

