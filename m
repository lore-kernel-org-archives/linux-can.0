From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2] candump: Add possibility to specify logfile
Date: Thu, 22 Aug 2013 08:04:21 +0200
Message-ID: <3017118.34njPKgRTv@ws-stein>
References: <52147A71.2080200@pengutronix.de> <1377076868-31679-1-git-send-email-alexander.stein@systec-electronic.com> <5214F1AB.30404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54276 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752790Ab3HVGEY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Aug 2013 02:04:24 -0400
In-Reply-To: <5214F1AB.30404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hello Oliver,

On Wednesday 21 August 2013 18:58:19, Oliver Hartkopp wrote:
> On 21.08.2013 11:21, Alexander Stein wrote:
> > You need to use -l/tmp/logfile (wihtout space!) because -l takes an
> > optional parameter.
> > 
> 
> Hm. I don't like that because of the "(without space!)"
> 
> If the option could have been passed like all other options (with space), it
> would have been ok. But not like this.
> 
> I know that this is a getopt problem ...

Exactly. I was wondering my self, but otherwise how can an optional parameter implemented in a different way?

> Btw. why can't you just use '-L' and redirect the output, e.g.
> 
> candump -L can0 > mylogfile.log

You can, certainly. I was just wondering why the user must not specify a logfile name at first place.

Regards,
Alexander

