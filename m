From: Oleksij Rempel <ore@pengutronix.de>
Subject: j1939 ACL
Date: Thu, 18 Jan 2018 10:40:40 +0100
Message-ID: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeARJkm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Jan 2018 04:40:42 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ec6ga-0005M2-Ov
        for linux-can@vger.kernel.org; Thu, 18 Jan 2018 10:40:40 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ec6ga-0003BL-GR
        for linux-can@vger.kernel.org; Thu, 18 Jan 2018 10:40:40 +0100
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

what is the proper or expected way for j1939 ACL (address claiming)?

Should it be done by automatically by kernel? Are there any existing
examples?

Is this a correct ACL message?
source address: for example 0x80
PGN: 0xee00
DATA: NAME

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
