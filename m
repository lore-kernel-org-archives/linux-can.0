From: David Jander <david@protonic.nl>
Subject: Re: j1939
Date: Wed, 5 Oct 2016 08:50:56 +0200
Message-ID: <20161005085056.63ef5e4c@erd980>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
        <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
        <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
        <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
        <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
        <20160920091525.2ff22d58@erd980>
        <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
        <20161004145202.6c5238d9@erd980>
        <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
        <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10742 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbcJEGu6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2016 02:50:58 -0400
In-Reply-To: <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

On Tue, 4 Oct 2016 19:32:02 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 10/04/2016 03:57 PM, Kurt Van Dijck wrote:
> > Recently, someone on this list was confronted with an engine ECU that
> > dropped TP that had the last packet not 8 bytes long.
> > And I believe I've encountered an issue a long time ago where this
> > happened on all PGNs.
> > So I introduced this option, having 3 possibilities:
> > * no padding
> > * padding for TP
> > * padding for all PGN.  
> 
> How to switch between padding for TP only and padding for all PGN?

Please don't. I think we should get rid of that last option. It is like trying
to correct HTTP GET request syntax in kernel-space if user-space is too lazy
to get it right. Don't do that.

Best regards,

-- 
David Jander
Protonic Holland.
