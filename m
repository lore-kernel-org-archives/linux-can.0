From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 08:38:42 +0200
Message-ID: <CAOpc7mGVRLW=ktoBhttgCAZnr7uYiSkS4H4Uk5b9kNVcB5-BOA@mail.gmail.com>
References: <559D35CA.2050402@uweschneider.de>
	<CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36376 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbGIGin (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 02:38:43 -0400
Received: by wgxm20 with SMTP id m20so31004811wgx.3
        for <linux-can@vger.kernel.org>; Wed, 08 Jul 2015 23:38:42 -0700 (PDT)
In-Reply-To: <CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

One more idea, and this is gonna make more work: is it possible to
split the patch into two?  The first one would receive via the
mailboxes.

And the second patch adds the sorting on this.

My vague idea is that the sorting can be done differently, e.g. here
in the mailing people talk currently about timestamping skbd, or about
RPS. Maybe it's possible to use an existing solution/framework and not
invent an own solution here.
