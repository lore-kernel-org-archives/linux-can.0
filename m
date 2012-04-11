From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 08:29:37 +0200
Message-ID: <2082927.TC8ExDXGjY@ws-stein>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50867 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab2DKG3l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 02:29:41 -0400
In-Reply-To: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Am Dienstag, 10. April 2012, 23:39:25 schrieb Fabio Baltieri:
> This patch adds two led triggers, named <ifname>-tx and <ifname>-rx to
> each registered canbus interface.

Does this mean, you can have either a tx or rx trigger, bot not both? The 
status LEDs I know from embedded system are triggered by both rx and tx.
Despite that, nice idea.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
