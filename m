Return-Path: <SRS0=2KO9=D6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDBC55178
	for <linux-can@archiver.kernel.org>; Fri, 23 Oct 2020 20:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3845C20897
	for <linux-can@archiver.kernel.org>; Fri, 23 Oct 2020 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbgJWUa4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:30:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42352 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756105AbgJWUa4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Oct 2020 16:30:56 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kW3i3-003Aol-Nn; Fri, 23 Oct 2020 22:30:47 +0200
Date:   Fri, 23 Oct 2020 22:30:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de,
        Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] add initial CAN PHY support
Message-ID: <20201023203047.GE752111@lunn.ch>
References: <20201023105626.6534-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023105626.6534-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Oct 23, 2020 at 12:56:20PM +0200, Oleksij Rempel wrote:
> This patch set is introducing PHY support for CAN.

The device tree binding needs documenting.

It might also help me get my head around the virtual MDIO bus and how
PHYs are added to it.

     Andrew
