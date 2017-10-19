From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: [PATCH 0/2] can: sun4i: bug fixes
Date: Thu, 19 Oct 2017 13:32:47 +0200
Message-ID: <e6e7fbec2dd041f4458f5818c637e1fa@gerhard-bertelsmann.de>
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:52816 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdJSLiw (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Oct 2017 07:38:52 -0400
Received: from webmail.rdts.de (php1.rdts.de [82.223.13.20])
        by mail.rdts.de (Postfix) with ESMTPSA id 29159A7216
        for <linux-can@vger.kernel.org>; Thu, 19 Oct 2017 13:32:48 +0200 (CEST)
In-Reply-To: <cover.1502971879.git.info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

Am 2017-08-17 15:59, schrieb GBert:
> From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
> 
> The patchset fixes two issues for Allwinner A10/A20 CAN IP
> 
> Gerhard Bertelsmann (2):
>   can: sun4i: fix overrun
>   can: sun4i: fix loopback mode
> 
>  drivers/net/can/sun4i_can.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

any chance to get these fixes integrated into the Linux kernel ?

Regards

Gerd
