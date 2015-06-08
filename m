From: Armin Burchardt <armin@uni-bremen.de>
Subject: Re: [PATCH 2/3] slcand: add option -p<file> to write pid to a file.
Date: Mon, 08 Jun 2015 13:43:27 +0000
Message-ID: <20150608134327.Horde.pLkodAvAfc3OuL7mi_j9ulf@webmail.uni-bremen.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
 <1433764540-24917-2-git-send-email-armin@uni-bremen.de>
 <557591E5.2080706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:60931 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753153AbbFHNn3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 09:43:29 -0400
In-Reply-To: <557591E5.2080706@pengutronix.de>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

> I think "/run/slcand/<IFACE>" would fit better into modern file system
> layout. What about having a default for the pid file path?

I would not expect a daemon to accept a filename (or only parts of it) without
a full path. The /etc/init.d/skeleton of Debian wheezy uses /var/run/$NAME.pid
(for start-stop-daemon's --pidfile option).
Do we know enough about the filesystem layout of existing (embedded)  
systems to define
a useful default?

> Does it make sense to open in exclusive mode?

If another daemon is started with the same pidfile we would have to give
up if the file already exists to take advantage of that. Is it  
expected of a daemon
using a pidfile to exit with an error or should it just overwrite an  
existing file?

Armin

