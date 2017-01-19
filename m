From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v6] can: dev: add CAN interface termination API
Date: Thu, 19 Jan 2017 13:41:03 +0100
Message-ID: <CAKT-o-fBAJVkUxCd-PcqeSV1=4ocPbMGod2aFTrqGo3JdFhvVg@mail.gmail.com>
References: <20170118145916.10580-1-mkl@pengutronix.de> <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>
 <7d6c2bc2-a1ae-cf9b-ea13-3a80405cfdd3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34041 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdASMty (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2017 07:49:54 -0500
Received: by mail-ua0-f179.google.com with SMTP id 35so32356648uak.1
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2017 04:49:28 -0800 (PST)
In-Reply-To: <7d6c2bc2-a1ae-cf9b-ea13-3a80405cfdd3@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Looks good to me. Tested as a part of mcba_usb v2 patch.

Regards,
Remik

On 19 January 2017 at 11:13, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/18/2017 06:48 PM, Oliver Hartkopp wrote:
>> Just a small issue in the commit message:
>>
>> On 01/18/2017 03:59 PM, Marc Kleine-Budde wrote:
>>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>> This patch adds a netlink interface to configure the CAN bus termination of
>>> CAN interfaces.
>>>
>>> Inside the driver an array of supported termination values is defined:
>>>
>>> const u16 drvname_termination[] = { 60, 120, CAN_TERMINATION_DISABLED };
>>>
>>> struct drvname_priv *priv;
>>> priv = netdev_priv(dev);
>>>
>>> priv->termination_const = &drvname_termination;
>>
>> This has to be:
>> priv->termination_const = drvname_termination;
>>
>> or we will get a incompatible pointer warning.
>>
>> Found the issue by adding the documentation PoC in usb_8dev for testing:
>
> Fixed.
>
> Thanks,
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
