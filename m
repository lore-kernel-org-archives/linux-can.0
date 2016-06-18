From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: build proc support only if CONFIG_PROC_FS is
 activated
Date: Sat, 18 Jun 2016 11:41:29 +0200
Message-ID: <57651749.7070603@hartkopp.net>
References: <1466165326-29777-1-git-send-email-mkl@pengutronix.de>
 <57650D13.1030706@hartkopp.net>
 <d8067cd1-12c7-56cf-30fc-5e88c2ee6a2e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:8459 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcFRJlf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jun 2016 05:41:35 -0400
In-Reply-To: <d8067cd1-12c7-56cf-30fc-5e88c2ee6a2e@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 06/18/2016 11:36 AM, Alexander Aring wrote:
>
> Hi,
>
> On 06/18/2016 10:57 AM, Oliver Hartkopp wrote:
>> Hi Alexander,
>>
>> there's a procfs dependency of the CAN_BCM too.
>>
>> On 06/17/2016 02:08 PM, Marc Kleine-Budde wrote:
>>> From: Alexander Aring <aar@pengutronix.de>
>>>
>>> When building can subsystem with CONFIG_PROC_FS=3Dn I detected some=
 unused
>>> variables warning by using proc functions.
>>
>> Did you miss to switch on CAN_BCM when doing a CONFIG_PROC_FS disabl=
ed test?
>>
>
> I detected the unused variable warnings while running randconfig, the
> first time I didn't saw the CAN_BCM but the second time (yet another
> randconfig) I saw CAN_BCM.
>
> net/can/bcm.c:235:37: warning: =91bcm_proc_fops=92 defined but not us=
ed
> [-Wunused-const-variable=3D]
>   static const struct file_operations bcm_proc_fops =3D {
>
>> Or is the procfs subsystem that intelligent that it just disables th=
e functionality so that the users (e.g. in bcm.c) don't need to care ab=
out CONFIG_PROC_FS.
>>
>
> It is such intelligent, but you have no static inline no-op's for
> functions which returns a pointer. It's:
>
> #define proc_fs_foobar NULL
>
> will be used and this occurs warnings while compiling. In case of
> can-proc you really don't need to link against it if CONFIG_PROC_FS
> isn't set - will turn off the warnings and compiles faster.
>
> The CAN_BCM should be fixed as well, most subsystem puts ifdefs aroun=
ds
> the proc functionality if it's not well outsourced like can-proc.c.
>
> Who will send a patch now?

=46eel free to sent a patch!
You detected the issue and as it turns out that you are capable to=20
create patches :-)

I would appreciate to see you as author then.

Thanks,
Oliver

>
> - Alex
>
