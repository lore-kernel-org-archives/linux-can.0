From: Manuele Conti <manuele.conti@archimede-energia.com>
Subject: RE: PROBLEM: usb_8dev driver can't get CAN_ERR_FLAG
Date: Wed, 18 Feb 2015 08:53:39 +0100
Message-ID: <3DBC6D34FF74DF48B9284D7A6A05A6750270AD384CA8@VB-SRVSBS.archimede.local>
References: <3DBC6D34FF74DF48B9284D7A6A05A6750270AD384CA2@VB-SRVSBS.archimede.local>,<54DE4B5B.8040702@universalnet.at>
 <3DBC6D34FF74DF48B9284D7A6A05A6750270AD384CA4@VB-SRVSBS.archimede.local>,<54E389F1.8020803@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from authsmtp20.register.it ([81.88.48.43]:50938 "EHLO
	authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751552AbbBRHzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Feb 2015 02:55:13 -0500
In-Reply-To: <54E389F1.8020803@universalnet.at>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Bernd,
I'm very sorry it work exactly as kernel documentation.

Cheers,
Manuele
________________________________________
=46rom: Bernd Krumboeck [krumboeck@universalnet.at]
Sent: Tuesday, February 17, 2015 7:35 PM
To: Manuele Conti
Cc: linux-can@vger.kernel.org
Subject: Re: PROBLEM: usb_8dev driver can't get CAN_ERR_FLAG

Hi Manuele!


1) Please check if "candump -e any,0:0,#FFFFFFFF" also ignores the erro=
r frames.
You can find candump in can-utils package.


2) Did your application request can error frames?

Please check chapter 4.1.2:
https://www.kernel.org/doc/Documentation/networking/can.txt


regards,
Bernd



Am 2015-02-17 um 11:53 schrieb Manuele Conti:
> Hi Bernd,
>
> 1. Firmware version
> [ 5017.267797] usb_8dev 3-1:1.0 can0: firmware: 1.5, hardware: 1.0
>
> 2. Schematic, connected devices, ...
> I connect device with a our BMS (Battery management system)
>
> 3. Exact description under which circumstances this problem occurs
> In our configuration the terminator resistor is handled by a device b=
y a mos-fet.
> So there are some devices that start to communicate on the bus before=
 net is terminated and bus errors occurs.
> On USB2Dev MS Windows driver gets frame errors but on Linux version t=
his doesn't happen.
>
>
> Cheers,
> Manuele
>
>
> ________________________________________
> From: Bernd Krumboeck [krumboeck@universalnet.at]
> Sent: Friday, February 13, 2015 8:07 PM
> To: Manuele Conti
> Cc: linux-can@vger.kernel.org
> Subject: Re: PROBLEM: usb_8dev driver can't get CAN_ERR_FLAG
>
> Dear Manuele!
>
>
> Sorry, but I can't follow:
> CAN_ERR_FLAG is set by alloc_can_err_skb function in can.c.
> The driver uses this function when receiving an error (usb_8dev_rx_er=
r_msg function) from device.
>
>
> Please provide following informations for further investigations:
> 1. Firmware version
> 2. Schematic, connected devices, ...
> 3. Exact description under which circumstances this problem occurs
>
>
>
> regards,
> Bernd
>
>
>
>
> Am 2015-02-13 um 17:36 schrieb Manuele Conti:
>> [1.] usb_8dev doesn't set CAN_ERR_FLAG when a bus error occurs.
>> [2.] It is not possible to get any error from an application because=
 driver doesn't set CAN_ERR_FLAG when a canbus error occurs.
>> [3.] modules, kernel, driver
>> [4.] Linux version 3.11.0-26-generic (buildd@comet) (gcc version 4.8=
=2E1 (Ubuntu/Linaro 4.8.1-10ubuntu8) ) #45-Ubuntu SMP Tue Jul 15 04:02:=
06 UTC 2014
>> [7]
>> [7.1]
>> If some fields are empty or look unusual you may have an old version=
=2E
>> Compare to the current minimal requirements in Documentation/Changes=
=2E
>>
>> DISTRIB_ID=3DUbuntu
>> DISTRIB_RELEASE=3D13.10
>> DISTRIB_CODENAME=3Dsaucy
>> DISTRIB_DESCRIPTION=3D"Ubuntu 13.10"
>> NAME=3D"Ubuntu"
>> VERSION=3D"13.10, Saucy Salamander"
>> ID=3Dubuntu
>> ID_LIKE=3Ddebian
>> PRETTY_NAME=3D"Ubuntu 13.10"
>> VERSION_ID=3D"13.10"
>> HOME_URL=3D"http://www.ubuntu.com/"
>> SUPPORT_URL=3D"http://help.ubuntu.com/"
>> BUG_REPORT_URL=3D"http://bugs.launchpad.net/ubuntu/"
>> Linux ThinkPad-Edge-E531 3.11.0-26-generic #45-Ubuntu SMP Tue Jul 15=
 04:02:06 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Gnu C                  gcc (Ubuntu/Linaro 4.8.1-10ubuntu9) 4.8.1
>> Gnu make               3.81
>> util-linux             linux 2.20.1
>> mount                  linux 2.20.1 (with libblkid and selinux suppo=
rt)
>> modutils               9
>> e2fsprogs              1.42.8
>> PPP                    2.4.5
>> Linux C Library        > libc.2.17
>> Dynamic linker (ldd)   2.17
>> Procps                 3.3.3
>> Net-tools              1.60
>> iproute2              iproute2-ss130716
>> Kbd                    1.15.5
>> Sh-utils               8.20
>> Modules Loaded         ftdi_sio usbserial michael_mic arc4 pci_stub =
vboxpci vboxnetadp vboxnetflt vboxdrv parport_pc ppdev rfcomm bnep binf=
mt_misc nfsd auth_rpcgss nfs_acl nfs lockd sunrpc fscache snd_hda_codec=
_hdmi snd_hda_codec_conexant joydev x86_pkg_temp_thermal intel_powercla=
mp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_i=
ntel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd=
 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core btusb video=
dev bluetooth snd_hda_intel snd_hda_codec snd_hwdep lib80211_crypt_tkip=
 microcode wl lib80211 psmouse cfg80211 i915 serio_raw snd_pcm rtsx_pci=
_ms memstick lpc_ich snd_page_alloc drm_kms_helper mei_me mei drm i2c_a=
lgo_bit thinkpad_acpi nvram snd_seq_midi snd_seq_midi_event snd_rawmidi=
 snd_seq snd_seq_device snd_timer snd wmi soundcore mac_hid video lp pa=
rport hid_generic usbhid hid rtsx_pci_sdmmc r8169 ahci rtsx_pci mii lib=
ahci
>>
>> free reports:
>>                total       used       free     shared    buffers    =
 cached
>> Mem:       7738552    7424740     313812          0    1023148    30=
76448
>> -/+ buffers/cache:    3325144    4413408
>> Swap:      8388604          0    8388604
>>
>> /proc/cpuinfo
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 0
>> cpu cores       : 4
>> apicid          : 0
>> initial apicid  : 0
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 1
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 0
>> cpu cores       : 4
>> apicid          : 1
>> initial apicid  : 1
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 2
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 1
>> cpu cores       : 4
>> apicid          : 2
>> initial apicid  : 2
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 3
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 1
>> cpu cores       : 4
>> apicid          : 3
>> initial apicid  : 3
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 4
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 2
>> cpu cores       : 4
>> apicid          : 4
>> initial apicid  : 4
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 5
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 2
>> cpu cores       : 4
>> apicid          : 5
>> initial apicid  : 5
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 6
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 3
>> cpu cores       : 4
>> apicid          : 6
>> initial apicid  : 6
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> processor       : 7
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 58
>> model name      : Intel(R) Core(TM) i7-3632QM CPU @ 2.20GHz
>> stepping        : 9
>> microcode       : 0x15
>> cpu MHz         : 1200.000
>> cache size      : 6144 KB
>> physical id     : 0
>> siblings        : 8
>> core id         : 3
>> cpu cores       : 4
>> apicid          : 7
>> initial apicid  : 7
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 13
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe s=
yscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt =
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsave=
opt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep =
erms
>> bogomips        : 4390.12
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 36 bits physical, 48 bits virtual
>> power management:
>>
>> [7.2]
>>
>> IMPORTANTE: il contenuto di questa e-mail e degli eventuali allegati=
, =E8 strettamente confidenziale e destinato alla/e persona/e a cui =E8=
 indirizzato.
>> Se avete ricevuto per errore questa e-mail, Vi preghiamo di segnalar=
celo immediatamente e di cancellarla dal vostro computer. E' fatto divi=
eto di copiare e divulgare il contenuto di questa e-mail. Ogni utilizzo=
 abusivo delle informazioni qui contenute da parte di persone terze o c=
omunque non indicate nella presente e-mail, potr=E0 essere perseguito a=
i sensi di legge.
>>
>> IMPORTANT: The contents of this email, and any attachments, are CONF=
IDENTIAL and intended only for the person(s) to whom they are addressed=
=2E
>> If you have received the email in error please notify the sender imm=
ediately and delete it from your computer system. Do not copy or distri=
bute it or disclose its contents to any person. Any improper use of the=
 contents of this email will be prosecuted by law.
>>
>
>
> IMPORTANTE: il contenuto di questa e-mail e degli eventuali allegati,=
 =E8 strettamente confidenziale e destinato alla/e persona/e a cui =E8 =
indirizzato.
> Se avete ricevuto per errore questa e-mail, Vi preghiamo di segnalarc=
elo immediatamente e di cancellarla dal vostro computer. E' fatto divie=
to di copiare e divulgare il contenuto di questa e-mail. Ogni utilizzo =
abusivo delle informazioni qui contenute da parte di persone terze o co=
munque non indicate nella presente e-mail, potr=E0 essere perseguito ai=
 sensi di legge.
>
> IMPORTANT: The contents of this email, and any attachments, are CONFI=
DENTIAL and intended only for the person(s) to whom they are addressed.
> If you have received the email in error please notify the sender imme=
diately and delete it from your computer system. Do not copy or distrib=
ute it or disclose its contents to any person. Any improper use of the =
contents of this email will be prosecuted by law.
>


IMPORTANTE: il contenuto di questa e-mail e degli eventuali allegati, =E8=
 strettamente confidenziale e destinato alla/e persona/e a cui =E8 indi=
rizzato.
Se avete ricevuto per errore questa e-mail, Vi preghiamo di segnalarcel=
o immediatamente e di cancellarla dal vostro computer. E' fatto divieto=
 di copiare e divulgare il contenuto di questa e-mail. Ogni utilizzo ab=
usivo delle informazioni qui contenute da parte di persone terze o comu=
nque non indicate nella presente e-mail, potr=E0 essere perseguito ai s=
ensi di legge.

IMPORTANT: The contents of this email, and any attachments, are CONFIDE=
NTIAL and intended only for the person(s) to whom they are addressed.
If you have received the email in error please notify the sender immedi=
ately and delete it from your computer system. Do not copy or distribut=
e it or disclose its contents to any person. Any improper use of the co=
ntents of this email will be prosecuted by law.
