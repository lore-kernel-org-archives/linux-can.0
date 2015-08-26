From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: SocketCAN on Intel Edison with MCP 2515
Date: Wed, 26 Aug 2015 14:54:23 +1000
Message-ID: <55DD467F.8080701@optusnet.com.au>
References: <CAKa_yg_Lrpw7J70UzJf5x2EeB6mrmbFarxgbYCf+xHyD8Nb2eQ@mail.gmail.com> <loom.20150825T164749-199@post.gmane.org>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:34246 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbbHZEy0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Aug 2015 00:54:26 -0400
In-Reply-To: <loom.20150825T164749-199@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rosemarie Sheehy <rsheehy@dairymaster.ie>, linux-can@vger.kernel.org

On 26/08/15 00:49, Rosemarie Sheehy wrote:
> Michael Gallagher <mjg <at> isomorphdevelopment.com> writes:

Actually:

On 28/05/15 01:18, Michael Gallagher wrote:
 > ...

He may not be monitoring this list after 3 months.

> I am trying to trying to set the can bus on the Edison.
> I have the expansion board and the can-bus shield
> (https://www.sparkfun.com/products/10039)

That's an Arduino Shield board on an adaptor on an Intel Edison running (I'm 
guessing) Yocto Linux. Good luck with that, you may be the first in the world 
to try that combination.

Did you read all the other posts in this thread? You may get some clues from them

Apparently the RPi Linux will automatically detect the CAN chips, but you'll 
have to consult the Yocto/Edison documentation to see if it has been set up by 
someone to do that.

Michael didn't say which hardware he was using.

As I said in another post "Linux used t be plug-and-play, but they fixed that 
bug". Devices on an I2C bus can sometimes be automatically identified, but the 
MCP2515 is on an SPI bus, and it can't autodetect chips. You have to add 
descriptions in the Device Tree File for your board (or add information to the 
Bootstrap Configuration so it can edit the Device Tree - more complications 
and more languages to learn to get a simple job done).

Check your Linux Source Tree "Documentation/devicetree/bindings/net/can" 
directory. Mine has documentation for cc770, flexcan, mscan, sj1000 but no 
mcp251x.

A more modern version of Linux has this:

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

That doesn't tell you where in the tree to add that section. I assume it has 
to be under/inside or reference an SPI controller somehow.

So to try and find a worked example, google for <compatible = "microchip,mcp2515">

http://www.microchip.com/forums/m828830.aspx

Also check "Documentation/devicetree/bindings/spi-bus.txt".

Remember the device doesn't show up as "/dev/can0", but shows up as a network 
device when you run "/sbin/ifconfig". It might also show up under /sys 
somewhere too. You then have to control it (to enable and set the baud rate) 
with "canconfig". If you don't have that software installed you may have to 
find/configure/build/install it as well.

Tom

