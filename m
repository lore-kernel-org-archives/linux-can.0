From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Fri, 08 Apr 2016 13:58:30 +0200
Message-ID: <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
References: <loom.20160405T174008-515@post.gmane.org> <20160406074653.GA28692@airbook.vandijck-laurijssen.be> <03B271BE48E2554EB34508DAB79DBABA87093BDE@POCITMSEXMB05.LntUniverse.com> <20160406194026.GD5242@airbook.vandijck-laurijssen.be> <03B271BE48E2554EB34508DAB79DBABA87095498@POCITMSEXMB05.LntUniverse.com> <20160408090444.GA5485@airbook.vandijck-laurijssen.be> <570793F6.7080808@eurek.it>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:58354 "EHLO
	relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcDHL6h (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2016 07:58:37 -0400
In-Reply-To: <570793F6.7080808@eurek.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: gianluca <gianlucarenzi@eurek.it>, Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 8 April 2016 13:20:22 CEST, gianluca <gianlucarenzi@eurek.it> wrote:
>On 04/08/2016 11:04 AM, Kurt Van Dijck wrote:
>> Hey,
>>
>>> Kurt,
>>> I am facing deb-pkg error while building the kernel. Need your
>guidance on that.
>>>
>>> Steps below.
>>> 1. I cloned the kernel from
>"http://kernel.ubuntu.com/git/kernel-ppa/mirror/ubuntu-vivid.git/commit/?id=32ac5b4aae56cf9446c30463663c8ae2226069da"
>with tag name "Ubuntu-3.19.0-56.62"
>>> 2. Then I added "git remote add j1939
>git://github.com/kurt-vd/linux"
>>> 3. git remote update j1939
>>> 4. git merge j1939/j1939d-v3.15
>>> 5. Merge was successful without any issues.
>>> 6. cp /boot/config-3.19.0.56-generic .config
>>> 7. yes ' ' | make oldconfig
>>> 8. make menuconfig -> added SAE J1939 support and debugging support
>for J1939 and CAN messages
>>> 9. make -j 3 deb-pkg LOCALVERSION=-custome
>>
>> I think you did everything well up to step 9.
>> My knowledge on building kernels specific for debian/Ubuntu  is
>limited.
>> Yet, the command you issue seems strange.
>> Shouldn't you just do:
>>
>> 	$ make -j 3 LOCALVERSION=-custome
>>
>> and then
>>
>> 	$ sudo make install
>>
>
>Nope. Eventually you have to compile the drivers too with a make
>modules.

$ make modules_install
was what I forgot.

>
>make deb-pkg will:
>
>1. compile the kernel and the static drivers
>2. compile the modules
>3. install the modules
>4. it will create the initrd for next boot.

I see...
I will try this, but what is the chance this works on a Slackware?

Kurt
Sent from a small mobile device
