From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] Add 32-bit accesses
Date: Mon, 05 May 2014 14:40:05 +0200
Message-ID: <536786A5.7070002@pengutronix.de>
References: <20140426203131.GA21832@amd.pavel.ucw.cz> <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com> <20140427122510.GB12901@amd.pavel.ucw.cz> <1398716449.836.4.camel@dinh-ubuntu> <20140428211505.GA28242@amd.pavel.ucw.cz> <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com> <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com> <20140430215359.GA15148@amd.pavel.ucw.cz> <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com> <20140502084851.GA5730@amd.pavel.ucw.cz> <20140505120801.GA16461@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39306 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbaEEMkM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 May 2014 08:40:12 -0400
In-Reply-To: <20140505120801.GA16461@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

On 05/05/2014 02:08 PM, Pavel Machek wrote:
> 
> Add helpers for 32-bit accesses and replace open-coded 32-bit access
> with calls to helpers.

In general looks good, but please add the modifications from the
platform file, where you add the 32 callbacks to this patch. Please
don't forget to modify the pci driver, too.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
