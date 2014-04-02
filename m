From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Regarding J1939 support on freescale imx6 BSP
Date: Wed, 2 Apr 2014 10:39:11 -0700
Message-ID: <CANGgnMZwgtU5fx17nbRUTn0fXUD2yC7RWPv0Nm7YU8OszMHETg@mail.gmail.com>
References: <533BAD63.80202@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43161 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619AbaDBRjM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 13:39:12 -0400
Received: by mail-wi0-f176.google.com with SMTP id r20so7634414wiv.15
        for <linux-can@vger.kernel.org>; Wed, 02 Apr 2014 10:39:11 -0700 (PDT)
In-Reply-To: <533BAD63.80202@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org

If you don't need the driver to handle the J1939 protocol, you don't
need to do anything special.  I'm using the CAN module to read the raw
extended frames directly, and doing all the message decoding, PGN,
source address, destination address and priority parsing from the CAN
ID myself in userspace.  Configure the interface to run at 250,000
bits/sec and you should be all set.

Austin

On Tue, Apr 1, 2014 at 11:25 PM, Ratheendran
<ba.rsrajeshwaran@tataelxsi.co.in> wrote:
> Hi All,
>
> I am new to Linux CAN module, want to know the how I can include this J1939
> support in my free-scale imx6 BSP. do you have a ready-made patch.
>
> Please note, there is no requirement that the driver handle J1939 protocol,
> it must simply allow J1939 to be fully functional.
>
> Thanks,
> Ratheendran
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
