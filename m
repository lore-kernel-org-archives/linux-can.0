From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: J1939: Unable to receive and transmit multi-frame messages
Date: Tue, 18 Feb 2020 11:46:59 +0100
Message-ID: <b7ed0f9e-117b-9555-8420-6cb41315a9b7@pengutronix.de>
References: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56003 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRKrB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 05:47:01 -0500
In-Reply-To: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org

Hi,

On 17.02.20 21:49, Elenita Hinds wrote:
> Hi,
> 
> Back when I was using just the J1939 branch (before it got re-written
> and mainlined), I was able to receive and transmit multi-frame
> messages.  Upgrading to kernel v5.4, this is no longer the case.

The upstreamed version is not binary compatible to the old version. Please make sure your 
application is properly updated.

> For the receive part, it is failing in j1939_tp_im_involved_anydir()
> call, which is the first thing called by j1939_tp_recv(). The socket
> is set to promiscuous mode; has no problem receiving ALL the  8-byte
> long messages but fails on longer ones. There should not be any
> difference with how the socket is setup as far as the message length
> goes  but is there a new step needed in order to receive the
> multi-frame messages as well?

The TP/ETP (multi-frame message) is the core functionality of j1939 stack. The 
functionality can be tested with cat-utils. See:
https://github.com/linux-can/can-utils/blob/master/can-j1939-kickstart.md

Please make sure you have all recent fixes:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/net/can/j1939

If you still have some issue, please provide code example, so we able to reproduce it.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
