From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: WG: PCAN-USB: new socketCAN driver available
Date: Tue, 29 Nov 2011 11:39:06 +0100
Message-ID: <4ED4B64A.2070500@grandegger.com>
References: <4E400A36.5050303@hartkopp.net> <A46279271E5345AC9BFA91C73DF57228@DA310MM05> <4E415AB2.5030102@hartkopp.net> <2CD045C79786404EA0A81CED1E59763D@DA310MM05> <4E4BFF24.2010508@hartkopp.net> <33575A72304940CE9103338BA3660CEA@DA310MM05> <26B4E6A46012A1469B4EB3BC2A7CAAEC01266CCC@vwagwox00084.vw.vwg> <4EC6597A.8040704@peak-system.com> <4EC6B080.8090808@hartkopp.net> <4ECB65D8.7050207@peak-system.com> <4ECB8E75.7@volkswagen.de> <4ECBAAFB.8080204@peak-system.com> <4ECBAE4E.8000502@volkswagen.de> <4ECBB49A.2020508@volkswagen.de> <4ED3B355.70209@peak-system.com> <26B4E6A46012A1469B4EB3BC2A7CAAECE55502@vwagwox00084.vw.vwg> <4ED3CC05.6060606@hartkopp.net> <4ED4AF93.8060309@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49436 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1K2KjJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Nov 2011 05:39:09 -0500
In-Reply-To: <4ED4AF93.8060309@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <peak@hartkopp.net>, "Maidhof, Michael" <m.maidhof@peak-system.com>, "U.Wilhelm (PEAK-System)" <u.wilhelm@peak-system.com>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org

On 11/29/2011 11:10 AM, Grosjean Stephane wrote:
> Hi Oliver,
> 
>>
>> "The right way" (TM) would be to clone David Millers net-next git tree:
>>
>> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;a=summary
> $ git clone
> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;a=summary
> Initialized empty Git repository in
> /home/peak/linux/drivers/linux-can/net-next/.git/
> f*atal:
> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git/info/refs
> not found: did you run git update-server-info on the server?*

Please use:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next

See also http://git.kernel.org/

Wolfgang.
