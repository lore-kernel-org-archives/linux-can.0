From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Bus-simulation with SocketCAN
Date: Tue, 10 Jan 2012 11:29:24 +0100
Message-ID: <4F0C1304.4060309@hartkopp.net>
References: <4F0B6B35.20104@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:25110 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab2AJK3a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 05:29:30 -0500
In-Reply-To: <4F0B6B35.20104@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jan-Niklas Meier <dschanoeh@googlemail.com>

Hello Sebastian,

On 09.01.2012 23:33, Sebastian Haas wrote:

> just in case someone is interested in an easy to way to simulate CAN nodes or
> to test ECUs via CAN. I want to inform you that my recently started project
> restcan [3] reached a first milestone. Look at [1] to know what restcan is.
> 
> The milestone includes the following features:
> - support of SocketCANs' RAW channels incl. Rx filters
> - support of a rudimentary JSON-based message database format


Do you know the Kayak project from Jan-Niklas Meier?

Kajak is a JAVA based frontend and library, see:

http://kayak.2codeornot2code.org/

http://kayak.2codeornot2code.org/tutorial.html

And on github: https://github.com/dschanoeh/Kayak

Implementing a restbus functionality in JAVA based on the Kajak library is
very easy - when  you are a JAVA developer ;-)

I like your approach to get a restbus simulation in C.

But checking your JSON description for CAN signals i stumbled about the
'intel' and 'motorola' tags which stand for 'little' and 'big' endian.

I wonder, if it makes sense for your project to adopt the XML-based KCD
format for CAN signal descriptions:

https://github.com/dschanoeh/Kayak/blob/ee6b459bddd1831ae99c1afcde01f315e4b454b4/Kayak-kcd/src/test/resources/can_definition_sample.kcd

Here is the XML schema definition:

https://github.com/dschanoeh/Kayak/blob/master/Kayak-kcd/src/main/resources/com/github/kayak/canio/kcd/schema/Definition.xsd

Maybe you can build your JSON description with an XSLT process from the well
defined KCD description.

There's also a dbc input converter on the run to create KCDs:
https://github.com/dschanoeh/CANBabel


> - support of receiving and decoding measurement values encoded in CAN
> messages, sending of such messages is also possible
> 
> See the examples in [5] to get an impression of using restcan.
> 
> Since my plans are big and I'm just one person with limited sparetime I ask
> everyone here to support this project with its mission to provide any easy to
> use way of accessing SocketCAN. See [4] for things I want to implement in the
> near future.
> 
> I hope Oliver is fine with "mis-"using the socketcan mailing list to announce
> this milestone of this very socketcan-related project. :-)


:-) This is not in my responsibility what is posted on SocketCAN-Users.
Btw. i put it onto the linux-can ML to continue the discussion there.

It's a good question, if we just do announcements on linux-can ML as i don't
know if the SocketCAN-Users ML will continue in the future.


> 
> [1] https://github.com/sebi2k1/restcan/wiki
> [2] http://sebi2k1.wordpress.com/2012/01/09/transmitting-and-receiving-physical-values-via-can/
> [3] https://github.com/sebi2k1/restcan
> [4] https://github.com/sebi2k1/restcan/blob/master/TODO.md
> [5] https://github.com/sebi2k1/restcan/tree/master/sample_scripts


Regards,
Oliver

