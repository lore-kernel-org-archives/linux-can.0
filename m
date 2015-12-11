From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
Date: Fri, 11 Dec 2015 17:01:04 +0100
Message-ID: <20151211160104.GU30206@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696DC8.8020708@pengutronix.de>
 <BY1PR0301MB1303A87AF2B3FFBB6CDA90EE82E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54481 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547AbbLKQBH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Dec 2015 11:01:07 -0500
Content-Disposition: inline
In-Reply-To: <BY1PR0301MB1303A87AF2B3FFBB6CDA90EE82E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sharma Bhupesh <bhupesh.sharma@freescale.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>

On Thu, Dec 10, 2015 at 12:22:55PM +0000, Sharma Bhupesh wrote:
> > If we have to rely on the timestamps the next logical step is to add
> > sorting by timestamp to the rx-fifo implementation. I'll send a
> > patch series of the current state.
> 
> With my current v3, I see no rx-frame ordering issues atleast on
> LS1021A.

Marc can post our testcases here on the list (maybe with the description
from the service request); perhaps this can clarify the issues.

> I can ask internally about more details on the "SR# 1-4074792564 : CAN
> Ordering Issues".

That would be quite helpful, thanks! Understanding the root cause of the
issue is often a good start, maybe there is an option for a software
workaround.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
