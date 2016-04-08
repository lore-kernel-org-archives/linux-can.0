From: gianluca <gianlucarenzi@eurek.it>
Subject: Re: J1939 Linux
Date: Fri, 8 Apr 2016 13:20:22 +0200
Message-ID: <570793F6.7080808@eurek.it>
References: <loom.20160405T174008-515@post.gmane.org>
 <20160406074653.GA28692@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87093BDE@POCITMSEXMB05.LntUniverse.com>
 <20160406194026.GD5242@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095498@POCITMSEXMB05.LntUniverse.com>
 <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from qmail.e-mind.com ([188.94.192.39]:49005 "HELO qmail.e-mind.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753459AbcDHLU0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 8 Apr 2016 07:20:26 -0400
In-Reply-To: <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/08/2016 11:04 AM, Kurt Van Dijck wrote:
> Hey,
>
>> Kurt,
>> I am facing deb-pkg error while building the kernel. Need your guidance on that.
>>
>> Steps below.
>> 1. I cloned the kernel from "http://kernel.ubuntu.com/git/kernel-ppa/mirror/ubuntu-vivid.git/commit/?id=32ac5b4aae56cf9446c30463663c8ae2226069da" with tag name "Ubuntu-3.19.0-56.62"
>> 2. Then I added "git remote add j1939 git://github.com/kurt-vd/linux"
>> 3. git remote update j1939
>> 4. git merge j1939/j1939d-v3.15
>> 5. Merge was successful without any issues.
>> 6. cp /boot/config-3.19.0.56-generic .config
>> 7. yes ' ' | make oldconfig
>> 8. make menuconfig -> added SAE J1939 support and debugging support for J1939 and CAN messages
>> 9. make -j 3 deb-pkg LOCALVERSION=-custome
>
> I think you did everything well up to step 9.
> My knowledge on building kernels specific for debian/Ubuntu  is limited.
> Yet, the command you issue seems strange.
> Shouldn't you just do:
>
> 	$ make -j 3 LOCALVERSION=-custome
>
> and then
>
> 	$ sudo make install
>

Nope. Eventually you have to compile the drivers too with a make modules.

make deb-pkg will:

1. compile the kernel and the static drivers
2. compile the modules
3. install the modules
4. it will create the initrd for next boot.

> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
