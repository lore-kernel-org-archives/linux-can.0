From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 20:40:36 +0200
Message-ID: <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
References: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:39201 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbcJDSld (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 14:41:33 -0400
Content-Disposition: inline
In-Reply-To: <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>


> On 10/04/2016 07:31 PM, Kurt Van Dijck wrote:
> >>
> >>> But often, especially for proprietary messages, not all 8 bytes are
> >>> used, and the DLC is cut accordingly.
> >>> And less often, this is done for TP too.
> >>> I also did that for as long as I can remember.
> >>> As long as all defined bytes are there, this should not really be a
> >>> problem.
> >>>
> >>> Recently, someone on this list was confronted with an engine ECU that
> >>> dropped TP that had the last packet not 8 bytes long.
> >>> And I believe I've encountered an issue a long time ago where this
> >>> happened on all PGNs.
> >>> So I introduced this option, having 3 possibilities:
> >>> * no padding
> >>> * padding for TP
> >>> * padding for all PGN.
> >>
> >> I have yet to check, but I fear that in ISOBus conformance tests on some
> >> places at least this is tested for. I'd say that if the standard says "pad and
> >> fill with 0xff", any ECU should do this and not doing it should be regarded as
> >> a bug... 
> > 
> > I (EIA Electronics) got a certified ISOBus Terminal with this code, back
> > in 2011, with this code (well, the code back then). I cannot remember
> > that I needed to pad TP.
> > The networking layer was the easy part in Potsdam, the layers above were
> > more difficult :-)
> > 
> > Things may have become more strict in between.
> > And we should be prepared for the strict setting.
> > On the other hand, during debugging, not padding helps identifying the
> > real data, and this has been valueable too for me.
> > 
> > I think we agree on what must be possible, we may just differ on the
> > defaults and how to set things.
> 
> It seems, or rather what I'd like to see is that we want most things to
> be per socket option. All module parameters should go away. The default
> for transport_max_size might be a system wide value, similar to
> /proc/sys/net/core/rmem_max.

do you propose to add /proc files?
I'm willing to replace module parameters with /proc files, but I don't
see the real advantage yet. And module parameters were quicker :-)

Kurt
