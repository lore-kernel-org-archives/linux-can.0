From: Jan-Niklas Meier <dschanoeh@googlemail.com>
Subject: Re: Bus-simulation with SocketCAN
Date: Sun, 15 Jan 2012 15:39:23 +0100
Message-ID: <D8DEE518-5DF9-4891-A348-1D3082E180C9@googlemail.com>
References: <4F0B6B35.20104@sebastianhaas.info> <4F0C1304.4060309@hartkopp.net> <4F0CA98E.2050400@sebastianhaas.info> <CAEuXk93BiNr816GocOHX8DS6g=2Lsyd4NPbbH1Hw0Gyc5RbAgA@mail.gmail.com> <4F108ED0.3080105@sebastianhaas.info> <4F1298D2.6040504@sebastianhaas.info>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41528 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab2AOOja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 15 Jan 2012 09:39:30 -0500
Received: by bkas6 with SMTP id s6so59308bka.19
        for <linux-can@vger.kernel.org>; Sun, 15 Jan 2012 06:39:28 -0800 (PST)
In-Reply-To: <4F1298D2.6040504@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: linux-can@vger.kernel.org

Hi Sebastian, 

Am 15.01.2012 um 10:13 schrieb Sebastian Haas:

> Hello Jan-Niklas,
> 
> I just adopted the KCD file format (see [1]). restcans' signal parser is missing support for muxed signals and converting signed/double is also not yet implemented. This points are already in the restcan issue tracker.
> 
> The parsing has also one limitation, if a signal has more than one "Value" tag, the parser always uses the first one.
> 
> Had you already time to play a bit with rest can?

It took some time for me to set up Node.js and get familiar with the module and add-on stuff. I built the can module successfully and could run the simple.js example which is quite neat.
I was not able to compile and install the can_signals module. Please check the issue I opened and the commits on my fork.

> I'm going to write a bigger example to show how to simulate different nodes on multiple buses.

That would be nice.

Today I started refactoring CANBabel to be able to add support for new file types. Hopefully I did not break anything but I will have to check this at work tomorrow :).

Greetings,
Jan-Niklas

