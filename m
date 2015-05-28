From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: ip -details link fails
Date: Thu, 28 May 2015 21:58:49 +0530
Message-ID: <BAY176-W13739EF0032A532E31F9F8D3CA0@phx.gbl>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>,<BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl>
 <5565FDE5.1040908@hartkopp.net>,<55661810.3050407@pengutronix.de>
 <BAY176-W52B59690F5605C23AA3A3D3CA0@phx.gbl>,<5567375A.404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc3s1.hotmail.com ([65.54.190.139]:65111 "EHLO
	BAY004-OMC3S1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbbE1Q2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 May 2015 12:28:50 -0400
In-Reply-To: <5567375A.404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Hi Oliver,
>
> On 28.05.2015 11:48, Ssagarr Patil wrote:
>> Hi Oliver,
>>
>>>
>>> On 05/27/2015 07:24 PM, Oliver Hartkopp wrote:
>>>>> # ip -details link show wlan0
>>>>> RTNETLINK answers: Invalid argument
>>>>> Cannot send link get request: Invalid argument
>>>>
>>>> The fact that your 'ip' tool doesn't work with wlan0 too your prob=
lem is
>>>> probably not CAN related.
>>>
>>> BTW: the busybox version of ip doesn't talk can.
>>>
>> I am not using the ip from the busybox,
>> I am using the release version from [1] (# ip -V
>> ip utility, iproute2-ss150413)
>>
>
> Looks good.
>
>>
>> # ip -details link show can0
>> RTNETLINK answers: Invalid argument
>> Cannot send link get request: Invalid argument
>> #
>>
>
>
>>
>> [1] https://www.kernel.org/pub/linux/utils/net/iproute2/
>>
>> Or is that I am missing something in the kernel defconfig do I need =
to enable some via
>> doing menuconfig to get it working
>
> Hm.
>
> Can you post the output of
>
> strace ip -details link show can0
>
> Maybe there"s really something missing in the kernel config to run th=
e netlink
> configuration.
>

execve("/sbin/ip", ["ip", "-details", "link", "show", "can0"], [/* 20 v=
ars */]) =3D 0
brk(0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x57000
uname({sysname=3D"Linux", nodename=3D"evm", ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x400ec000
access("/etc/ld.so.preload", R_OK)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such fil=
e or directory)
open("/lib/tls/v7l/neon/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENO=
ENT (No such file or directory)
stat64("/lib/tls/v7l/neon/vfp", 0xbec4b3f0) =3D -1 ENOENT (No such file=
 or directory)
open("/lib/tls/v7l/neon/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT =
(No such file or directory)
stat64("/lib/tls/v7l/neon", 0xbec4b3f0) =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/v7l/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (=
No such file or directory)
stat64("/lib/tls/v7l/vfp", 0xbec4b3f0)=A0 =3D -1 ENOENT (No such file o=
r directory)
open("/lib/tls/v7l/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No s=
uch file or directory)
stat64("/lib/tls/v7l", 0xbec4b3f0)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/tls/neon/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT =
(No such file or directory)
stat64("/lib/tls/neon/vfp", 0xbec4b3f0) =3D -1 ENOENT (No such file or =
directory)
open("/lib/tls/neon/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No =
such file or directory)
stat64("/lib/tls/neon", 0xbec4b3f0)=A0=A0=A0=A0 =3D -1 ENOENT (No such =
file or directory)
open("/lib/tls/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No s=
uch file or directory)
stat64("/lib/tls/vfp", 0xbec4b3f0)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/tls/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such =
file or directory)
stat64("/lib/tls", 0xbec4b3f0)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT=
 (No such file or directory)
open("/lib/v7l/neon/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT =
(No such file or directory)
stat64("/lib/v7l/neon/vfp", 0xbec4b3f0) =3D -1 ENOENT (No such file or =
directory)
open("/lib/v7l/neon/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No =
such file or directory)
stat64("/lib/v7l/neon", 0xbec4b3f0)=A0=A0=A0=A0 =3D -1 ENOENT (No such =
file or directory)
open("/lib/v7l/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No s=
uch file or directory)
stat64("/lib/v7l/vfp", 0xbec4b3f0)=A0=A0=A0=A0=A0 =3D -1 ENOENT (No suc=
h file or directory)
open("/lib/v7l/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such =
file or directory)
stat64("/lib/v7l", 0xbec4b3f0)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT=
 (No such file or directory)
open("/lib/neon/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No =
such file or directory)
stat64("/lib/neon/vfp", 0xbec4b3f0)=A0=A0=A0=A0 =3D -1 ENOENT (No such =
file or directory)
open("/lib/neon/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such=
 file or directory)
stat64("/lib/neon", 0xbec4b3f0)=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT (=
No such file or directory)
open("/lib/vfp/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No such =
file or directory)
stat64("/lib/vfp", 0xbec4b3f0)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D -1 ENOENT=
 (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0l\t\0\0004\0\0\0=
"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D15193, ...}) =3D 0
mmap2(NULL, 41144, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0=
) =3D 0x4015e000
mprotect(0x40160000, 28672, PROT_NONE)=A0 =3D 0
mmap2(0x40167000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_DENYWRITE, 3, 0x1000) =3D 0x40167000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
open("/lib/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\340\315\0\0004\=
0\0\0"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D1532904, ...}) =3D 0
mmap2(NULL, 152480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, =
0) =3D 0x400ad000
mprotect(0x400cb000, 28672, PROT_NONE)=A0 =3D 0
mmap2(0x400d2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_DENYWRITE, 3, 0x1d000) =3D 0x400d2000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0H\205\1\0004\0\0=
\0"..., 512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1545368, ...}) =3D 0
mmap2(NULL, 1242504, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,=
 0) =3D 0x40169000
mprotect(0x4028c000, 28672, PROT_NONE)=A0 =3D 0
mmap2(0x40293000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x122000) =3D 0x40293000
mmap2(0x40296000, 9608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x40296000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x400d3000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x4010e000
set_tls(0x4010e4c0, 0x4010eba8, 0x400ac050, 0x4010e4c0, 0x400ac050) =3D=
 0
mprotect(0x40293000, 8192, PROT_READ)=A0=A0 =3D 0
mprotect(0x40167000, 4096, PROT_READ)=A0=A0 =3D 0
mprotect(0x400ab000, 4096, PROT_READ)=A0=A0 =3D 0
socket(PF_NETLINK, SOCK_RAW|SOCK_CLOEXEC, NETLINK_ROUTE) =3D 3
setsockopt(3, SOL_SOCKET, SO_SNDBUF, [32768], 4) =3D 0
setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) =3D 0
bind(3, {sa_family=3DAF_NETLINK, pid=3D0, groups=3D00000000}, 12) =3D 0
getsockname(3, {sa_family=3DAF_NETLINK, pid=3D236, groups=3D00000000}, =
[12]) =3D 0
gettimeofday({946684864, 166689}, NULL) =3D 0
send(3, " \0\0\0\20\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0", 32, 0) =3D 32
recvmsg(3, {msg_name(12)=3D{sa_family=3DAF_NETLINK, pid=3D0, groups=3D0=
0000000}, msg_iov(1)=3D[{"4\0\0\0\2\0\0\0\0\0\0\0\354\0\0\0\355\377\377=
\377 \0\0\0\20\0\5\0\2
access("/proc/net", R_OK)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 0
access("/proc/net/unix", R_OK)=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
socket(PF_LOCAL, SOCK_DGRAM|SOCK_CLOEXEC, 0) =3D 4
ioctl(4, SIOCGIFINDEX, {ifr_name=3D"can0", ifr_index=3D4}) =3D 0
close(4)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
send(3, "(\0\0\0\22\0\1\3\301Cm8\0\0\0\0\21\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"..., 40, 0) =3D 40
recvmsg(3, {msg_name(12)=3D{sa_family=3DAF_NETLINK, pid=3D0, groups=3D0=
0000000}, msg_iov(1)=3D[{"\254\1\0\0\20\0\2\0\301Cm8\354\0\0\0\0\0\4\3\=
1\0\0\0I\0\1\0\0\0\0\0
brk(0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x57000
brk(0x78000)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D 0x78000
recvmsg(3, {msg_name(12)=3D{sa_family=3DAF_NETLINK, pid=3D0, groups=3D0=
0000000}, msg_iov(1)=3D[{"\24\0\0\0\3\0\2\0\301Cm8\354\0\0\0\0\0\0\0", =
16384}], msg_controll0
fstat64(1, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(253, 0), ...}) =3D=
 0
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x40299000
write(1, "4: can0: <NOARP,UP,LOWER_UP,ECHO"..., 934: can0: <NOARP,UP,LO=
WER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
) =3D 93
write(1, "=A0=A0=A0 link/can \n", 14=A0=A0=A0 link/can=20
)=A0=A0=A0=A0=A0=A0=A0=A0 =3D 14
open("/usr/lib/ip/link_can.so", O_RDONLY|O_CLOEXEC) =3D -1 ENOENT (No s=
uch file or directory)
write(1, "=A0=A0=A0 can <TRIPLE-SAMPLING> state "..., 84=A0=A0=A0 can <=
TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms=
 0=20
) =3D 84
write(1, "\t=A0 bitrate 500000 sample-point 0"..., 38=A0=A0=A0=A0=A0=A0=
 bitrate 500000 sample-point 0.875=20
) =3D 38
write(1, "\t=A0 tq 250 prop-seg 3 phase-seg1 "..., 53=A0=A0=A0=A0=A0=A0=
 tq 250 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
) =3D 53
write(1, "\t=A0 c_can: tseg1 2..16 tseg2 1..8"..., 64=A0=A0=A0=A0=A0=A0=
 c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
) =3D 64
write(1, "\t=A0 clock 20000000\n", 18=A0=A0=A0=A0=A0=A0 clock 20000000
)=A0=A0=A0 =3D 18
exit_group(0)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D ?
+++ exited with 0 +++
#=20


But I got it working with iproute2 release 3.15.0 (ip utility, iproute2=
-ss140610) from [1]
Not sure Why it fails with 4.0.0.

[1] https://www.kernel.org/pub/linux/utils/net/iproute2/

Thanks,
Sagar

 		 	   		  