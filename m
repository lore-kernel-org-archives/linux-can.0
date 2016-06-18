From: Alexander Aring <aar@pengutronix.de>
Subject: Re: [PATCH v2] can: build proc support only if CONFIG_PROC_FS is
 activated
Date: Sat, 18 Jun 2016 13:15:41 +0200
Message-ID: <6dcab1d0-274c-eac9-0c36-eb098823e3c2@pengutronix.de>
References: <1466165326-29777-1-git-send-email-mkl@pengutronix.de>
 <57650D13.1030706@hartkopp.net>
 <d8067cd1-12c7-56cf-30fc-5e88c2ee6a2e@pengutronix.de>
 <57651749.7070603@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52563 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbcFRLPo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jun 2016 07:15:44 -0400
In-Reply-To: <57651749.7070603@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Hi,

On 06/18/2016 11:41 AM, Oliver Hartkopp wrote:
>=20
>=20
> On 06/18/2016 11:36 AM, Alexander Aring wrote:
>>
>> Hi,
>>
>> On 06/18/2016 10:57 AM, Oliver Hartkopp wrote:
>>> Hi Alexander,
>>>
>>> there's a procfs dependency of the CAN_BCM too.
>>>
>>> On 06/17/2016 02:08 PM, Marc Kleine-Budde wrote:
>>>> From: Alexander Aring <aar@pengutronix.de>
>>>>
>>>> When building can subsystem with CONFIG_PROC_FS=3Dn I detected som=
e unused
>>>> variables warning by using proc functions.
>>>
>>> Did you miss to switch on CAN_BCM when doing a CONFIG_PROC_FS disab=
led test?
>>>
>>
>> I detected the unused variable warnings while running randconfig, th=
e
>> first time I didn't saw the CAN_BCM but the second time (yet another
>> randconfig) I saw CAN_BCM.
>>
>> net/can/bcm.c:235:37: warning: =91bcm_proc_fops=92 defined but not u=
sed
>> [-Wunused-const-variable=3D]
>>   static const struct file_operations bcm_proc_fops =3D {
>>
>>> Or is the procfs subsystem that intelligent that it just disables t=
he functionality so that the users (e.g. in bcm.c) don't need to care a=
bout CONFIG_PROC_FS.
>>>
>>
>> It is such intelligent, but you have no static inline no-op's for
>> functions which returns a pointer. It's:
>>
>> #define proc_fs_foobar NULL
>>
>> will be used and this occurs warnings while compiling. In case of
>> can-proc you really don't need to link against it if CONFIG_PROC_FS
>> isn't set - will turn off the warnings and compiles faster.
>>
>> The CAN_BCM should be fixed as well, most subsystem puts ifdefs arou=
nds
>> the proc functionality if it's not well outsourced like can-proc.c.
>>
>> Who will send a patch now?
>=20
> Feel free to sent a patch!
> You detected the issue and as it turns out that you are capable to cr=
eate patches :-)
>=20
> I would appreciate to see you as author then.
>=20

warning doesn't show anymore. I tried everything to enable the
-Wunused-const-variable=3D1 stuff while compiling and verbose output.

I think this was some kind of gcc change and I used my host compiler
which occured this warning in a special gcc version.

My gcc version is now and it seems they revert the change:

gcc (GCC) 6.1.1 20160602

and I don't see such warning anymore when CONFIG_PROC_FS isn't set.

Anyway I would keep the first change which makes more clear error
handling if CONFIG_PROC_FS is not build-in vs proc entry creation was
failed. At last compiling is faster.

Sorry for the noise.

- Alex
