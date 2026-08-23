#!/bin/bash

# Functie voor de helptekst
usage() {
    echo "Gebruik: $0 <RSS_FEED_URL> [--num-episodes <N>] [-h|--help]"
    echo ""
    echo "Argumenten:"
    echo "  <RSS_FEED_URL>       De URL van de RSS feed (verplicht)"
    echo ""
    echo "Opties:"
    echo "  --num-episodes <N>   Aantal meest recente afleveringen om te downloaden (optioneel)"
    echo "  -h, --help           Toon deze helptekst"
    exit 1
}

# Controleer op -h of --help direct als argument
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
fi

# Verplichte eerste argument (URL) afvangen
if [ -z "$1" ] || [[ "$1" == -* ]]; then
    echo "Fout: RSS_FEED_URL is verplicht."
    echo ""
    usage
fi

FEED_URL="$1"
SHIFT_COUNT=1
NUM_EPISODES=""

# Verwerk de overige argumenten
shift $SHIFT_COUNT
while [[ $# -gt 0 ]]; do
    case "$1" in
        --num-episodes)
            if [ -n "$2" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
                NUM_EPISODES="$2"
                shift 2
            else
                echo "Fout: --num-episodes vereist een positief getal."
                echo ""
                usage
            fi
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Fout: Onbekend argument '$1'"
            echo ""
            usage
            ;;
    esac
done

# Samenstellen van het Docker Command
CMD_ARGS=("$FEED_URL" "/downloads")

# Alleen toevoegen als --num-episodes daadwerkelijk is meegegeven
if [ -n "$NUM_EPISODES" ]; then
    CMD_ARGS+=("--num-episodes" "$NUM_EPISODES")
fi

# Uitvoeren
docker compose run --rm --remove-orphans podcast-downloader "${CMD_ARGS[@]}"
