From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Fri, 20 Nov 2015 14:10:08 +0300
Message-ID: <20151120111008.GZ7289@mwanda>
References: <20151119124219.GC2638@mwanda>
 <20151120081921.GA32659@thinkoso.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:28101 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbKTLKe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2015 06:10:34 -0500
Content-Disposition: inline
In-Reply-To: <20151120081921.GA32659@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Could you fix this and give me a reported-by tag?  I can't test it and
it's weird to me that CAN_ERR_PROT_LOC_CRC_SEQ is always used as a
bitmap.

The static checker is a Smatch thing I'm working on but haven't
published yet.  It only finds this bug and a couple false positives.

regards,
dan carpenter

